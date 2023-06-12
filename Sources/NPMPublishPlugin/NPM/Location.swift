import struct Files.Folder
import Foundation
import Publish
import ShellOut

extension NPM {
  /// An enum listing each representing the location of **npm** project.
  public enum Location {
    /// A case that represents a project located in a folder.
    case folder(Files.Folder)

    /// A case that represents a project located at a specific path.
    case path(Path)
  }
}
