import struct Files.Folder
import Foundation
import Publish
import ShellOut

extension NPM {
  /// A type that represents the path  of **npm** command
  ///  and directory to run the command from.
  public struct Settings {
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

    /// The custom path to the **npm** executable.
    public let npmPath: String

    /// The location of the **npm** project.
    public let location: Location

    /// Gets the folder that contains the **npm** project.
    ///
    /// - Parameter context: The context that will be used to resolve the folder.
    /// - Returns: The folder that contains the **npm** project.
    internal func folder(usingContext context: Context) throws -> Files.Folder {
      switch self.location {
      case let .folder(folder):
        return folder

      case let .path(path):
        return try context.folder(at: path)
      }
    }
  }
}
