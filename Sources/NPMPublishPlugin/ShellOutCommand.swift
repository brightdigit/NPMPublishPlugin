import struct Files.Folder
import Foundation
import Publish
import ShellOut

// swiftlint:disable function_body_length
public extension ShellOutCommand {
  /// This creates a `ShellOutCommand` that represents npm expression to execute.
  ///
  ///  - Parameters:
  ///    - job: This is the npm command to execute, passed with any arguments, and output paths.
  ///    - settings: Any settings required for npm job to run like npm executable path, project location, etc.
  ///    - context: The context in which to run the NPM job.
  ///  - Throws: An error if the project folder cannot be retrieved or output paths cannot be created.
  ///  - Returns: The resulting `ShellOutCommand`.
  static func npm(
    _ job: NPM.Job,
    withSettings settings: NPM.Settings,
    andContext context: NPM.Context
  ) throws -> ShellOutCommand {
    let folder = try settings.folder(usingContext: context)

    // Build map for the output paths and their string representation on the file system.
    let outputPathMap = try job.outputRelativePaths.reduce(
      into: [OutputPath: String]()
    ) { partialResult, path in
      let output = try context.createOutput(for: path)

      partialResult[path] = output.url.relativePath(from: folder.url)
    }

    // Build string represetnation of all npm job arguments.
    let argumentsArray: [String] = job.arguments.map { arg in
      switch arg {
      case let .string(value):
        return value

      case let .path(path):
        let outputPath = outputPathMap[path] ?? ""
        return "\"\(outputPath)\""
      }
    }

    // Build ShellOutCommand from the string representation of npm command and its arguments.
    let arguments = argumentsArray.joined(separator: " ")
    let npmPath = settings.npmPath
    let subcommandString = job.subcommand.string
    return ShellOutCommand(string: "\(npmPath) \(subcommandString) \(arguments)")
  }
}

// swiftlint:enable function_body_length
