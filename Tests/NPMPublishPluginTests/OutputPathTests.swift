import struct Files.Folder
@testable import NPMPublishPlugin
import Publish
import XCTest

internal final class OutputPathTests: XCTestCase {
  internal func testFile() {
    let outputPath: OutputPath = .init(
      path: .init(temporaryFolder.path),
      type: .file
    )

    XCTAssertEqual(temporaryFolder.path, outputPath.path.string)
  }

  internal func testFolder() {
    let outputPath: OutputPath = .init(
      path: .init(temporaryFolder.path),
      type: .folder
    )

    XCTAssertEqual(temporaryFolder.path, outputPath.path.string)
  }
}
