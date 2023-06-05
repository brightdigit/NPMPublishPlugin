import struct Files.Folder
import Foundation
import Publish
import ShellOut

// swiftlint:disable function_default_parameter_at_end
public extension PublishingStep {
  /// Runs the specified NPM jobs with the given settings.
  ///
  /// - Parameters:
  ///   - jobs: A builder to create a list of one or more npm jobs to run.
  ///   - settings: The npm settings to use.
  ///   - Returns: A `PublishingStep` that runs the specified npm jobs.
  static func npm(run jobs: [NPM.Job], withSettings settings: NPM.Settings) -> Self {
    .step(named: "Running npm Job...") { context in
      let folderPath = try settings.folder(usingContext: context).path

      let commands: [ShellOutCommand] = try jobs.map { job in
        try .npm(job, withSettings: settings, andContext: context)
      }

      for command in commands {
        try shellOut(to: command, at: folderPath)
      }
    }
  }

  /// Runs one or more npm job in the current folder.
  ///
  /// - Parameters:
  ///   - npmPath: The path to the npm executable.
  ///   - jobs: A builder to create a list of one or more npm jobs to run.
  /// - Returns: A `PublishingStep` that represents the npm job.
  static func npm(
    _ npmPath: String? = nil,
    at folder: Folder = .current,
    @NPM.JobBuilder _ jobs: () -> [NPM.Job]
  ) -> Self {
    Self.npm(
      run: jobs(),
      withSettings: .init(npmPath: npmPath, location: .folder(folder))
    )
  }

  /// Runs an npm job in the folder at the given path.
  ///
  /// - Parameters:
  ///   - npmPath: The path to the npm executable.
  ///   - relativePath: The path to the folder where the npm job will be run.
  ///   - jobs: A builder to create a list of one or more npm jobs to run.
  /// - Returns: A `PublishingStep` that represents the npm job.
  static func npm(
    _ npmPath: String? = nil,
    at relativePath: Path,
    @NPM.JobBuilder _ jobs: () -> [NPM.Job]
  ) -> Self {
    Self.npm(
      run: jobs(),
      withSettings: .init(npmPath: npmPath, location: .path(relativePath))
    )
  }
}

// swiftlint:enable function_default_parameter_at_end
