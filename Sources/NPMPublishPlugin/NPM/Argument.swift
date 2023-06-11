import Foundation
import Publish
import ShellOut

/// An enum representing the type of arguments to pass to the npm command.
public extension NPM {
  enum Argument: ExpressibleByStringLiteral {
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
