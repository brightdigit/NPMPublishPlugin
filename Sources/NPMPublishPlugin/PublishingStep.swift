import struct Files.Folder
import Foundation
import Publish
import ShellOut

/// Extension methods for running a set of **npm** commands within **Publish**.
///
/// `NPMPublishPlugin` includes three ways to create a **Publish** step to run **npm**.
/// Firstly, you can suppy a ``NPM/Settings`` and an array of ``NPM/Job`` items.
///
/// Hoever most likely  you'll want to to use the other two methods which you can pass:
///
/// * an opational path to the **npm** command
/// * an optional path to the *current directory* to run from
///  as either a `Folder` or `Path ` object from **Publish**
/// * using the ``NPM/JobBuilder`` pass the series jobs
///  similar to how **SwiftUI** builds `View`s using its DSL
extension PublishingStep {
  /// Runs the specified **npm** jobs with the given settings.
  ///
  /// - Parameters:
  ///   - jobs: A builder to create a list of one or more **npm** jobs to run.
  ///   - settings: The **npm** settings to use.
  ///   - Returns: A `PublishingStep` that runs the specified **npm** jobs.
  public static func npm(
    run jobs: [NPM.Job],
    withSettings settings: NPM.Settings
  ) -> Self {
    .step(named: "Running **npm** Job...") { context in
      let folderPath = try settings.folder(usingContext: context).path

      let commands: [ShellOutCommand] = try jobs.map { job in
        try .npm(job, withSettings: settings, andContext: context)
      }

      for command in commands {
        try shellOut(to: command, at: folderPath)
      }
    }
  }

  /// Runs one or more **npm** job in the current folder.
  ///
  /// - Parameters:
  ///   - npmPath: The path to the **npm** executable.
  ///   - folder: The directory to run **npm** from.
  ///   - jobs: A builder to create a list of one or more **npm** jobs to run.
  /// - Returns: A `PublishingStep` that represents the **npm** job.
  public static func npm(
    _ npmPath: String? = nil,
    at folder: Folder = .current,
    @NPM.JobBuilder _ jobs: () -> [NPM.Job] = { [] }
  ) -> Self {
    Self.npm(
      run: jobs(),
      withSettings: .init(npmPath: npmPath, location: .folder(folder))
    )
  }

  /// Runs an **npm** job in the folder at the given path.
  ///
  /// - Parameters:
  ///   - npmPath: The path to the **npm** executable.
  ///   - relativePath: The relative path to the folder where the **npm** job will be run.
  ///   - jobs: A builder to create a list of one or more **npm** jobs to run.
  /// - Returns: A `PublishingStep` that represents the **npm** job.
  public static func npm(
    _ npmPath: String? = nil,
    at relativePath: Path = ".",
    @NPM.JobBuilder _ jobs: () -> [NPM.Job] = { [] }
  ) -> Self {
    Self.npm(
      run: jobs(),
      withSettings: .init(npmPath: npmPath, location: .path(relativePath))
    )
  }
}
