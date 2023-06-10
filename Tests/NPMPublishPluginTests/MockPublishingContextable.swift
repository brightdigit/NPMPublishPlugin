import Files
import NPMPublishPlugin
import Publish
import XCTest

class MockPublishingContextable: PublishingContextable {
  var passedOutputPathFile: Publish.Path?
  var passedOutputPathFolder: Publish.Path?

  private let folder: Files.Folder = .temporary

  func createOutputFile(at path: Publish.Path) throws -> Files.File {
    passedOutputPathFile = path
    return try folder.createFile(at: path.string)
  }

  func createOutputFolder(at path: Publish.Path) throws -> Files.Folder {
    passedOutputPathFolder = path
    return try folder.createSubfolder(named: path.string)
  }

  func folder(at _: Publish.Path) throws -> Files.Folder {
    fatalError()
  }
}
