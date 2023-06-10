import XCTest
import Publish
@testable import NPMPublishPlugin

internal final class PublishingContextableTests: XCTestCase {
  internal func testCreateOutputWithFile() throws {
    let mock = MockPublishingContextable()

    let actualFilePath: Path = .init(UUID().uuidString)

    _ = try mock.createOutput(for: .file(actualFilePath))

    XCTAssertEqual(mock.passedOutputPathFile, actualFilePath)
  }

  internal func testCreateOutputWithFolder() throws {
    let mock = MockPublishingContextable()

    let actualFilePath: Path = .init(UUID().uuidString)

    _ = try mock.createOutput(for: .folder(actualFilePath))

    XCTAssertEqual(mock.passedOutputPathFolder, actualFilePath)
  }
}
