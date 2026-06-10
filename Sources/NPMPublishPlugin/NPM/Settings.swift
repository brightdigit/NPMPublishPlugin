//
//  Settings.swift
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

import struct Files.Folder

extension NPM {
  /// A type that represents the path  of **npm** command
  ///  and directory to run the command from.
  public struct Settings {
    /// The custom path to the **npm** executable.
    public let npmPath: String

    /// The location of the **npm** project.
    public let location: Location

    /// Initializes a `Settings` instance with a custom **npm** path and project location.
    ///
    /// - Parameters:
    ///   - npmPath: The custom path to the **npm** executable.
    ///   - location: The path/folder location of the **npm** project.
    public init(npmPath: String? = nil, location: Location = .folder(Folder.current)) {
      self.npmPath = npmPath ?? "npm"
      self.location = location
    }

    /// Initializes a `Settings` instance with the given **npm** path and folder.
    ///
    /// - Parameters:
    ///   - npmPath: The custom path to the **npm** executable.
    ///   - folder: The folder location of the **npm** project.
    public init(npmPath: String? = nil, folder: Files.Folder = .current) {
      self.init(npmPath: npmPath, location: .folder(folder))
    }

    /// Initializes a `Settings` instance with the given **npm** path and path.
    ///
    /// - Parameters:
    ///   - npmPath: The custom path to the **npm** executable.
    ///   - path: The path location to the **npm** project.
    public init(npmPath: String? = nil, path: Path = Path(".")) {
      self.init(npmPath: npmPath, location: .path(path))
    }

    /// Gets the folder that contains the **npm** project.
    ///
    /// - Parameter context: The context that will be used to resolve the folder.
    /// - Returns: The folder that contains the **npm** project.
    internal func folder(usingContext context: Context) throws -> Files.Folder {
      switch self.location {
      case .folder(let folder):
        return folder

      case .path(let path):
        return try context.folder(at: path)
      }
    }
  }
}
