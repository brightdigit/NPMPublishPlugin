import struct Files.Folder
import Foundation
import Publish
import ShellOut

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
