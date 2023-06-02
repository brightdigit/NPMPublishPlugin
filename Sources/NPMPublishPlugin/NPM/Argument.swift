import Foundation
import Publish
import ShellOut

public extension NPM {
  typealias StringLiteralType = String

  enum Argument: ExpressibleByStringLiteral {
    case string(String)
    case path(OutputPath)

    public init(stringLiteral value: String) {
      self = .string(value)
    }
  }
}
