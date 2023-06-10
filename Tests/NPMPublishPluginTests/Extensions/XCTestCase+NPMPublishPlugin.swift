import XCTest
import struct Files.File
import struct Files.Folder

@testable import NPMPublishPlugin

internal extension XCTestCase {
  typealias NPMSettings = NPM.Settings

  var temporaryFolder: Files.Folder { .temporary }
}
