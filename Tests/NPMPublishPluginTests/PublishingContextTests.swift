import Files
import NPMPublishPlugin
import Publish
import XCTest

internal final class PublishingContextableTests: XCTestCase {
  internal func testCreateOutputWithFile() throws {
    let mock = MockPublishingContextable()
    let actualFilePath = Path(UUID().uuidString)
    _ = try mock.createOutput(for: .file(actualFilePath))

    XCTAssertEqual(mock.outputPathFilePassed, actualFilePath)
  }

  internal func testCreateOutputWitholder() throws {
    XCTFail("Missing Implementation for " + #function)
  }
}
