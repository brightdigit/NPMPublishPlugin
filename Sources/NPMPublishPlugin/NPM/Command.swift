//
//  Command.swift
//  NPMPublishPlugin
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import Publish
import ShellOut

extension NPM {
  /// A type that represents **npm** command.
  public struct Command: ExpressibleByStringLiteral {
    // MARK: Predefined Commands

    // swiftlint:disable identifier_name
    /// The `ci` **npm** command.
    public static let ci: Self = .init("ci")
    // swiftlint:enable identifier_name

    /// The `run` **npm** command.
    public static let run: Self = .init("run")

    /// The string representation of the command.
    public let string: String

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
  }
}
