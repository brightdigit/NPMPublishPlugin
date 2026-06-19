//
//  ArgumentBuilder.swift
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

extension NPM {
  /// A result builder for building a list of one or more **npm** `Argument`s.
  @resultBuilder
  public enum ArgumentBuilder {
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
