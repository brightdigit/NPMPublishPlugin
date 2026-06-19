import Publish
import XCTest

import struct Files.Folder

@testable import NPMPublishPlugin

internal final class NPMInvocationTests: XCTestCase {
  internal func testNPM() throws {
    let commandString = "npm init --yes"

    let npmCommand: NPMInvocation = try .npm(
      .init(subcommand: .init("init")) {
        .init(stringLiteral: "--yes")
      },
      withSettings: NPM.Settings(location: .folder(Folder.current)),
      andContext: MockPublishingContextable()
    )

    XCTAssertEqual(npmCommand.string, commandString)
  }
}
