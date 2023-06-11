import Foundation
import Publish
import ShellOut

public extension NPM {
  /// A type that represents an npm command execution.
  struct Job {
    /// Initializes a new npm `Job` with the given arguments and output paths.
    ///
    /// - Parameters:
    ///   - subcommand: The npm command.
    ///   - outputRelativePaths: Any output paths required by npm.
    ///   - arguments: Any additional arguments to pass to the npm command.
    public init(
      subcommand: Command,
      outputRelativePaths: [OutputPath] = [],
      arguments: [Argument] = []
    ) {
      self.subcommand = subcommand
      self.outputRelativePaths = outputRelativePaths
      self.arguments = arguments
    }

    /// Initializes a new npm `Job` with the given arguments and output paths.
    ///
    /// - Parameters:
    ///   - subcommand: The npm command.
    ///   - outputRelativePaths: Any output paths required by npm.
    ///   - argBuilder: Arguments to pass to the npm command.
    public init(
      subcommand: Command,
      outputRelativePaths: [OutputPath] = [],
      @NPM.ArgumentBuilder _ argBuilder: () -> [Argument]
    ) {
      self.subcommand = subcommand
      self.outputRelativePaths = outputRelativePaths
      arguments = argBuilder()
    }

    /// The npm command to run.
    public let subcommand: Command

    /// The relative paths of any output files that should be copied to the output folder.
    public let outputRelativePaths: [OutputPath]

    /// Any additional arguments to pass to the npm command.
    public let arguments: [Argument]
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
///   - paths: The output paths required for npm command to finish its job.
///   - argBuilder: A builder for any additional of arguments to pass to the npm command.
/// - Returns: An ``NPM/Job`` instance for the `run` command.
public func run(
  paths: [OutputPath] = [],
  @NPM.ArgumentBuilder _ arguments: () -> [NPM.Argument]
) -> NPM.Job {
  .init(subcommand: .run, outputRelativePaths: paths, arguments)
}
