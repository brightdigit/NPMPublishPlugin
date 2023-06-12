import Foundation
import Publish
import ShellOut

extension NPM {
  /// A type that represents **npm** command.
  public struct Command: ExpressibleByStringLiteral {
    /// Initializes a new **npm** command with the specified string representation.
    ///
    /// - Parameter string: A string representing an **npm** command.
    public init(_ string: String) {
      self.string = string
    }

    /// Initializes a new **npm** command with the specified string literal.
    ///
    /// - Parameter value: A string literal representing an **npm** command.
    public init(stringLiteral value: String) {
      string = value
    }

    /// The string representation of the command.
    public let string: String

    // MARK: Predefined Commands

    /// The `ci` **npm** command.
    // swiftlint:disable:next identifier_name
    public static let ci: Self = .init("ci")

    /// The `run` **npm** command.
    public static let run: Self = .init("run")
  }
}
