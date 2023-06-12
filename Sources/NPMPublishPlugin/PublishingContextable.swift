import struct Files.File
import struct Files.Folder
import Foundation
import Publish
import ShellOut

internal protocol PublishingContextable: NPMContext {
  /// Create a file at a given path within the website's output folder.
  /// - parameter path: The path to create a file at.
  /// - throws: An error in case the file couldn't be created.
  func createOutputFile(at path: Path) throws -> File

  /// Create a folder at a given path within the website's output folder.
  /// - parameter path: The path to create a folder at.
  /// - throws: An error in case the folder couldn't be created.
  func createOutputFolder(at path: Path) throws -> Folder
}

extension PublishingContextable {
  /// Creates an output file or folder at the given path.
  ///
  /// - Parameter path: The path to the output file or folder.
  /// - Returns: The output file or folder.
  internal func createOutput(for path: OutputPath) throws -> Output {
    switch path.type {
    case .file:
      return try self.createOutputFile(at: path.path)

    case .folder:
      return try self.createOutputFolder(at: path.path)
    }
  }
}
