import Foundation
import Publish
import ShellOut

/// A wrapper type holding the path and the type for output file/folder.
public struct OutputPath: Equatable, Hashable {
  /// An enum representing the type of output path.
  public enum OutputType {
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
