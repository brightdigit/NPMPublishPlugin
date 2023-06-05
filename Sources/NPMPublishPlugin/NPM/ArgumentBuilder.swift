import Foundation
import Publish
import ShellOut

public extension NPM {
  /// A result builder for building a list of one or more npm `Argument`s.
  @resultBuilder
  enum ArgumentBuilder {
    /// Builds argument list from a single `Argument`.
    ///
    /// - Parameter expression: A single argument to be built.
    /// - Returns: An array containing single argument.
    public static func buildExpression(_ expression: Argument) -> [Argument] {
      [expression]
    }

    /// Builds argument list from a single `Argument` of type `path`.
    ///
    /// - Parameter expression: An output path to be built as a path argument.
    /// - Returns: An array containing single argument.
    public static func buildExpression(_ expression: OutputPath) -> [Argument] {
      [.path(expression)]
    }

    /// Builds argument list from a list of `Argument`s.
    ///
    /// - Parameter components: One or more argument.
    /// - Returns: An array containing all of the `Argument`s in `components`.
    public static func buildBlock(_ components: [Argument]...) -> [Argument] {
      components.flatMap { $0 }
    }
  }
}
