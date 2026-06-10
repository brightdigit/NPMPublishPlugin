//
//  Argument.swift
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
    case .string(let value):
      return value

    case .path(let path):
      let outputPath = dictionary[path] ?? defaultValue
      return "\"\(outputPath)\""
    }
  }
}
