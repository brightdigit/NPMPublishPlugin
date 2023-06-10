import struct Files.File
import struct Files.Folder
import XCTest

@testable import NPMPublishPlugin

internal typealias NPMSettings = NPM.Settings

internal extension XCTestCase {
  // swiftlint:disable:next explicit_acl
  var temporaryFolder: Files.Folder { .temporary }
}
