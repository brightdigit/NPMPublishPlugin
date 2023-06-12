import Foundation
import Publish
import ShellOut

/// An enum representing the type of arguments to pass to the **npm** command.
extension NPM {
  /// An argument to pass to an **npm** command
  /// whether it's a simple string or a reference to an output path from **Publish.**
  public enum Argument: ExpressibleByStringLiteral {
    /// A string argument.
    case string(String)

    /// An output path argument.
    case path(OutputPath)

    /// Creates an instance of `Argument` with a string literal.
    ///
    /// - Parameter value: A string literal representing an argument of type `string`.
    public init(stringLiteral value: String) {
      self = .string(value)
    }
  }
}

extension NPM.Argument {
  internal func relativePath(
    basedOn dictionary: NPM.RelativePathMap,
    withDefaultValue defaultValue: String = ""
  ) -> String {
    switch self {
    case let .string(value):
      return value

    case let .path(path):
      let outputPath = dictionary[path] ?? defaultValue
      return "\"\(outputPath)\""
    }
  }
}
