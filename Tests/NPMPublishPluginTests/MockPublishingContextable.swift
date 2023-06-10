import Files
import NPMPublishPlugin
import Publish
import XCTest

internal class MockPublishingContextable: PublishingContextable {
  internal var passedOutputPathFile: Publish.Path?
  internal var passedOutputPathFolder: Publish.Path?

  private let folder: Files.Folder = .temporary

  internal func createOutputFile(at path: Publish.Path) throws -> Files.File {
    passedOutputPathFile = path
    return try folder.createFile(at: path.string)
  }

  internal func createOutputFolder(at path: Publish.Path) throws -> Files.Folder {
    passedOutputPathFolder = path
    return try folder.createSubfolder(named: path.string)
  }

  // swiftlint:disable:next unavailable_function
  internal func folder(at _: Publish.Path) throws -> Files.Folder {
    fatalError("unavailable")
  }
}
