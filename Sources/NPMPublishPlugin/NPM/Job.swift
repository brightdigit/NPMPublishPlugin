//
//  Job.swift
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

import Files
import Foundation
import Publish

extension NPM {
  /// A type that represents an **npm** command execution.
  public struct Job: Sendable {
    /// The **npm** command to run.
    public let subcommand: Command

    /// The relative paths of any output files that should be copied to the output folder.
    public let outputRelativePaths: [OutputPath]

    /// Any additional arguments to pass to the **npm** command.
    public let arguments: [Argument]

    /// Initializes a new **npm** `Job` with the given arguments and output paths.
    ///
    /// - Parameters:
    ///   - subcommand: The **npm** command.
    ///   - outputRelativePaths: Any output paths required by npm.
    ///   - arguments: Any additional arguments to pass to the **npm** command.
    public init(
      subcommand: Command,
      outputRelativePaths: [OutputPath] = [],
      arguments: [Argument] = []
    ) {
      self.subcommand = subcommand
      self.outputRelativePaths = outputRelativePaths
      self.arguments = arguments
    }

    /// Initializes a new **npm** `Job` with the given arguments and output paths.
    ///
    /// - Parameters:
    ///   - subcommand: The **npm** command.
    ///   - outputRelativePaths: Any output paths required by npm.
    ///   - argBuilder: Arguments to pass to the **npm** command.
    public init(
      subcommand: Command,
      outputRelativePaths: [OutputPath] = [],
      @NPM.ArgumentBuilder _ argBuilder: () -> [Argument]
    ) {
      self.subcommand = subcommand
      self.outputRelativePaths = outputRelativePaths
      arguments = argBuilder()
    }
  }
}

extension NPM.Job {
  /// Creates the output files and folder and
  ///  returns a `Dictionary` of the ``OutputPath`` and the resulting relative path.
  /// - Parameters:
  ///   - context: The **npm** context used to create the output files and folders.
  ///   - folder: `Folder` from which to return the relative paths to.
  /// - Returns: `Dictionary` of the ``OutputPath`` and the resulting relative path.
  /// - Throws: An error in case an output file or folder couldn't be created.
  internal func createOutput(
    using context: NPM.Context,
    relativeTo folder: Files.Folder
  ) throws -> NPM.RelativePathMap {
    try outputRelativePaths.reduce(
      into: [OutputPath: String]()
    ) { partialResult, path in
      let output = try context.createOutput(for: path)
      partialResult[path] = output.url.relativePath(from: folder.url)
    }
  }
}

/// This helper function creates an `NPM.Job` instance for the `npm ci` command.
/// - Returns: A `NPM.Job` instance that runs the `ci` command.
public func ci() -> NPM.Job {
  .init(subcommand: .ci)
}

/// This helper function creates an ``NPM/Job`.
///
/// - Parameters:
///   - paths: The output paths required for **npm** command to finish its job.
///   - arguments: A builder for any additional arguments
///    to pass to the **npm** command.
/// - Returns: An ``NPM/Job`` instance for the `run` command.
public func run(
  paths: [OutputPath] = [],
  @NPM.ArgumentBuilder _ arguments: () -> [NPM.Argument]
) -> NPM.Job {
  .init(subcommand: .run, outputRelativePaths: paths, arguments)
}
