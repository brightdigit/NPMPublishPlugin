import struct Files.Folder
import Foundation
import Publish
import ShellOut

extension PublishingContext: NPMContext {
  /// Creates an output file or folder at the given path.
  ///
  /// - Parameter path: The path to the output file or folder.
  /// - Returns: The output file or folder.
  public func createOutput(for path: OutputPath) throws -> Output {
    switch path.type {
    case .file:
      return try self.createOutputFile(at: path.path)

    case .folder:
      return try self.createOutputFolder(at: path.path)
    }
  }
}
