import Foundation
import Publish
import ShellOut

public extension NPM {
  /// A result builder for building a list of npm jobs.
  @resultBuilder
  enum JobBuilder {
    /// Builds a list of npm jobs.
    /// This can be used to run multiple npm commands sequentially.
    ///
    /// - Parameter components: One or more job.
    /// - Returns: The list of npm jobs.
    public static func buildBlock(_ components: Job...) -> [Job] {
      components
    }
  }
}
