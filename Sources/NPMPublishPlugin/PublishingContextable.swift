//
//  PublishingContextable.swift
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

import struct Files.File
import struct Files.Folder

internal protocol PublishingContextable: NPMContext {
  /// Create a file at a given path within the website's output folder.
  /// - Parameter path: The path to create a file at.
  /// - Returns: The created file.
  /// - Throws: An error in case the file couldn't be created.
  func createOutputFile(at path: Path) throws -> File

  /// Create a folder at a given path within the website's output folder.
  /// - Parameter path: The path to create a folder at.
  /// - Returns: The created folder.
  /// - Throws: An error in case the folder couldn't be created.
  func createOutputFolder(at path: Path) throws -> Folder
}

extension PublishingContextable {
  /// Creates an output file or folder at the given path.
  ///
  /// - Parameter path: The path to the output file or folder.
  /// - Returns: The output file or folder.
  /// - Throws: An error in case the file or folder couldn't be created.
  internal func createOutput(for path: OutputPath) throws -> Output {
    switch path.type {
    case .file:
      return try self.createOutputFile(at: path.path)

    case .folder:
      return try self.createOutputFolder(at: path.path)
    }
  }
}
