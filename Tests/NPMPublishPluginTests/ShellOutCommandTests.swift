import struct Files.Folder
@testable import NPMPublishPlugin
import Publish
import ShellOut
import XCTest

internal final class ShellOutCommandTests: XCTestCase {
  internal func testNPM() throws {
    let commandString = "npm init --yes"

    let npmCommand: ShellOutCommand = try .npm(
      .init(subcommand: .init("init")) {
        .init(stringLiteral: "--yes")
      },
      withSettings: NPM.Settings(location: .folder(Folder.current)),
      andContext: MockPublishingContextable()
    )

    XCTAssertEqual(npmCommand.string, commandString)
  }
}
