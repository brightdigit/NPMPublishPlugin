import struct Files.Folder
import Foundation
import Publish

/// A protocol that defines an NPM context.
public protocol NPMContext {
  /// Creates an output file or folder at the given path.
  ///
  /// - Parameter path: The path to the output file or folder.
  /// - Returns: The output file or folder.
  func createOutput(for path: OutputPath) throws -> Output

  /// Gets the folder at the given path.
  ///
  /// - Parameter path: The path to the folder.
  /// - Returns: The folder.
  func folder(at path: Path) throws -> Folder
}

public extension NPM {
  /// A context type as part of NPM namespace
  typealias Context = NPMContext
}
