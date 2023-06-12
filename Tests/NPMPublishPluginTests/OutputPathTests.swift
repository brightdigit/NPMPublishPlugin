import struct Files.Folder
@testable import NPMPublishPlugin
import Publish
import XCTest

internal final class OutputPathTests: XCTestCase {
  internal func testFile() {
    let outputPath: OutputPath = .init(
      path: .init(Files.Folder.temporary.path),
      type: .file
    )

    XCTAssertEqual(Files.Folder.temporary.path, outputPath.path.string)
  }

  internal func testFolder() {
    let outputPath: OutputPath = .init(
      path: .init(Files.Folder.temporary.path),
      type: .folder
    )

    XCTAssertEqual(Files.Folder.temporary.path, outputPath.path.string)
  }
}
