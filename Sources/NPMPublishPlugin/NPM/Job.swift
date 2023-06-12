import Files
import Foundation
import Publish
import ShellOut

extension NPM {
  /// A type that represents an **npm** command execution.
  public struct Job {
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

    /// The **npm** command to run.
    public let subcommand: Command

    /// The relative paths of any output files that should be copied to the output folder.
    public let outputRelativePaths: [OutputPath]

    /// Any additional arguments to pass to the **npm** command.
    public let arguments: [Argument]
  }
}

extension NPM.Job {
  /// Creates the output files and folder and
  ///  returns a `Dictionary` of the ``OutputPath`` and the resulting relative path.
  /// - Parameters:
  ///   - context: `PublishingContext` from **Publish**
  ///   - folder: `Folder` from which to return the relative paths to.
  /// - Returns: `Dictionary` of the ``OutputPath`` and the resulting relative path.
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
///   - argBuilder: A builder for any additional of arguments
///    to pass to the **npm** command.
/// - Returns: An ``NPM/Job`` instance for the `run` command.
public func run(
  paths: [OutputPath] = [],
  @NPM.ArgumentBuilder _ arguments: () -> [NPM.Argument]
) -> NPM.Job {
  .init(subcommand: .run, outputRelativePaths: paths, arguments)
}
