import Files
import NPMPublishPlugin
import Publish
import XCTest

class MockPublishingContextable: PublishingContextable {
  var outputPathFilePassed: Publish.Path?
  var outputPathFolderPassed: Publish.Path?

  func createOutputFolder(at path: Publish.Path) throws -> Files.Folder {
    outputPathFolderPassed = path
    return try .init(path: path.string)
  }

  func createOutputFile(at path: Publish.Path) throws -> Files.File {
    outputPathFilePassed = path
    return try .init(path: path.string)
  }

  func folder(at _: Publish.Path) throws -> Files.Folder {
    fatalError()
  }
}
