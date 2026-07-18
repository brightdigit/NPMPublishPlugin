//
//  NPMInvocation.swift
//  NPMPublishPlugin
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import Publish

#if canImport(Subprocess)
  import Subprocess

  import struct Files.Folder

  /// A resolved **npm** invocation describing the executable and its arguments.
  ///
  /// This replaces the previous `ShellOutCommand` abstraction. It captures the
  /// **npm** executable path and the fully-resolved argument list so the command
  /// can be run directly with `swift-subprocess` (no shell required).
  internal struct NPMInvocation: Sendable, Equatable {
    /// The path to (or name of) the **npm** executable.
    internal let npmPath: String

    /// The resolved arguments to pass to **npm** (subcommand + any arguments).
    internal let arguments: [String]

    /// A shell-style string representation of the full command (e.g. `npm init --yes`).
    internal var string: String {
      ([npmPath] + arguments).joined(separator: " ")
    }

    /// This creates an `NPMInvocation` that represents the **npm** expression to execute.
    ///
    ///  - Parameters:
    ///    - job: This is the **npm** command to execute.
    ///    - settings: Any settings required for **npm** job.
    ///    - context: The context in which to run the NPM job.
    ///  - Throws: An error if the project folder cannot be retrieved or
    ///  output paths cannot be created.
    ///  - Returns: The resulting `NPMInvocation`.
    internal static func npm(
      _ job: NPM.Job,
      withSettings settings: NPM.Settings,
      andContext context: NPM.Context
    ) throws -> NPMInvocation {
      let folder = try settings.folder(usingContext: context)

      // Build map for the output paths and their string representation on the file system.
      let outputPathMap = try job.createOutput(using: context, relativeTo: folder)

      // Build string represetnation of all **npm** job arguments.
      let argumentsArray: [String] = job.arguments.map {
        $0.relativePath(basedOn: outputPathMap)
      }

      let subcommandString = job.subcommand.string
      return NPMInvocation(
        npmPath: settings.npmPath,
        arguments: [subcommandString] + argumentsArray
      )
    }

    /// Escapes spaces in a path so it survives being embedded in a shell command,
    /// matching the behaviour previously provided by `ShellOut`.
    private static func escapingSpaces(_ value: String) -> String {
      value.replacingOccurrences(of: " ", with: "\\ ")
    }

    /// Runs the **npm** invocation in the given directory.
    ///
    /// The command string is executed through `bash` so that argument tokens
    /// embedded within a single ``NPM/Argument`` (and any output-path quoting)
    /// are split and interpreted exactly as they were under the previous
    /// `ShellOut`-based implementation.
    ///
    /// - Parameter path: The working directory to run the command from.
    /// - Throws: ``NPMInvocationError`` if the process exits with a non-zero status.
    internal func run(at path: String) async throws {
      let command = "cd \(Self.escapingSpaces(path)) && \(string)"

      let result = try await Subprocess.run(
        .name("bash"),
        arguments: ["-c", command],
        output: .discarded,
        error: .string(limit: .max)
      )

      guard result.terminationStatus.isSuccess else {
        throw NPMInvocationError(
          command: command,
          terminationStatus: result.terminationStatus,
          standardError: result.standardError ?? ""
        )
      }
    }
  }
#endif
