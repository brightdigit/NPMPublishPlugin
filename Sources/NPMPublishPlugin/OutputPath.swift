import Foundation
import Publish
import ShellOut

public struct OutputPath: Equatable, Hashable {
  public enum OutputType {
    case file
    case folder
  }

  public let path: Path
  public let type: OutputType

  public static func file(_ path: Path) -> Self {
    .init(path: path, type: .file)
  }

  public static func folder(_ path: Path) -> Self {
    .init(path: path, type: .folder)
  }
}
