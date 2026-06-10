//
//  OutputPath.swift
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

/// A wrapper type holding the path and the type for output file/folder.
public struct OutputPath: Equatable, Hashable, Sendable {
  /// An enum representing the type of output path.
  public enum OutputType: Sendable {
    case file
    case folder
  }

  /// The path to the output file/folder.
  public let path: Path

  /// The type of the output file/folder
  public let type: OutputType

  /// Creates an `OutputPath` instance that represents a file with the given path.
  ///
  /// - Parameter path: The path to the output file.
  public static func file(_ path: Path) -> Self {
    .init(path: path, type: .file)
  }

  /// Creates an `OutputPath` instance that represents a folder with the given path.
  ///
  /// - Parameter path: The path to the output folder.
  public static func folder(_ path: Path) -> Self {
    .init(path: path, type: .folder)
  }
}
