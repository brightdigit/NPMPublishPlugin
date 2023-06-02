import struct Files.Folder
import Foundation
import Publish
import ShellOut

// swiftlint:disable function_body_length
public extension ShellOutCommand {
  /// Initialize a git repository
  static func npm(
    _ job: NPM.Job,
    withSettings settings: NPM.Settings,
    andContext context: NPM.Context
  ) throws -> ShellOutCommand {
    let folder = try settings.folder(usingContext: context)

    let outputPathMap = try job.outputRelativePaths.reduce(
      into: [OutputPath: String]()
    ) { partialResult, path in
      let output = try context.createOutput(for: path)

      partialResult[path] = output.url.relativePath(from: folder.url)
    }
    let argumentsArray: [String] = job.arguments.map { arg in
      switch arg {
      case let .string(value):
        return value

      case let .path(path):
        let outputPath = outputPathMap[path] ?? ""
        return "\"\(outputPath)\""
      }
    }
    let arguments = argumentsArray.joined(separator: " ")
    let npmPath = settings.npmPath
    let subcommandString = job.subcommand.string
    return ShellOutCommand(string: "\(npmPath) \(subcommandString) \(arguments)")
  }
}

// swiftlint:enable function_body_length
