//
//  ShellOutCommand.swift
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
import ShellOut

import struct Files.Folder

@_documentation(visibility: private)
extension ShellOutCommand {
  /// This creates a `ShellOutCommand` that represents **npm** expression to execute.
  ///
  ///  - Parameters:
  ///    - job: This is the **npm** command to execute.
  ///    - settings: Any settings required for **npm** job.
  ///    - context: The context in which to run the NPM job.
  ///  - Throws: An error if the project folder cannot be retrieved or
  ///  output paths cannot be created.
  ///  - Returns: The resulting `ShellOutCommand`.
  internal static func npm(
    _ job: NPM.Job,
    withSettings settings: NPM.Settings,
    andContext context: NPM.Context
  ) throws -> ShellOutCommand {
    let folder = try settings.folder(usingContext: context)

    // Build map for the output paths and their string representation on the file system.
    let outputPathMap = try job.createOutput(using: context, relativeTo: folder)

    // Build string represetnation of all **npm** job arguments.
    let argumentsArray: [String] = job.arguments.map {
      $0.relativePath(basedOn: outputPathMap)
    }

    // Build `ShellOutCommand` from the string representation.
    let arguments = argumentsArray.joined(separator: " ")
    let npmPath = settings.npmPath
    let subcommandString = job.subcommand.string
    return ShellOutCommand(string: "\(npmPath) \(subcommandString) \(arguments)")
  }
}
