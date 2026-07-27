import Files
import Foundation
import Publish

@testable import NPMPublishPlugin

/// A minimal ``NPMContext`` that resolves any path to a fixed folder and records
/// the requested path, used to exercise the `.path` branch of
/// ``NPM/Settings/folder(usingContext:)``.
internal final class FolderResolvingContext: NPMContext {
  internal private(set) var requestedPath: Publish.Path?

  private let resolved: Files.Folder

  internal init(resolved: Files.Folder) {
    self.resolved = resolved
  }

  // swiftlint:disable:next unavailable_function
  internal func createOutput(for _: OutputPath) throws -> Output {
    fatalError("unavailable")
  }

  internal func folder(at path: Publish.Path) throws -> Files.Folder {
    requestedPath = path
    return resolved
  }
}
