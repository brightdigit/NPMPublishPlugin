import XCTest
import Publish
import ShellOut

import struct Files.Folder
@testable import NPMPublishPlugin

internal final class ShellOutCommandTests: XCTestCase {
  internal func testNPM() throws {
    let commandString = "npm init --yes"

//    let s: ShellOutCommand = try .npm(
//      .init(subcommand: .ci),
//      withSettings: NPMSettings.init(location: .folder(Folder.current)),
//      andContext: <#T##NPM.Context#>
//    )
//
//    XCTAssertEqual(s.string, commandString)
  }
}

//internal struct TestContext: NPMContext {
//  func createOutput(for path: NPMPublishPlugin.OutputPath) throws -> NPMPublishPlugin.Output {
//    // try Files.Folder.createSubfolder(Files.Folder.temporary)
//  }
//
//  func folder(at path: Publish.Path) throws -> Files.Folder {
//    //.temporary
//  }
//}
