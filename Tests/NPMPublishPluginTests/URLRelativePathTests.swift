import Foundation
import Testing

@testable import NPMPublishPlugin

@Suite("URL Relative Path")
internal struct URLRelativePathTests {
  @Test("Nested child resolves relative to its ancestor")
  internal func nestedChildRelativeToAncestor() {
    let base = URL(fileURLWithPath: "/a/b", isDirectory: true)
    let dest = URL(fileURLWithPath: "/a/b/c/d", isDirectory: true)

    #expect(dest.relativePath(from: base) == "c/d")
  }

  @Test("Sibling paths climb with ..")
  internal func siblingPathsClimbWithDotDot() {
    let base = URL(fileURLWithPath: "/a/b/c", isDirectory: true)
    let dest = URL(fileURLWithPath: "/a/b/d", isDirectory: true)

    #expect(dest.relativePath(from: base) == "../d")
  }

  @Test("Identical URLs return an empty string")
  internal func identicalURLsReturnEmptyString() {
    let url = URL(fileURLWithPath: "/a/b/c", isDirectory: true)

    #expect(url.relativePath(from: url)?.isEmpty == true)
  }

  @Test("Non-file URLs return nil")
  internal func nonFileURLReturnsNil() throws {
    let base = URL(fileURLWithPath: "/a/b", isDirectory: true)
    let remote = try #require(URL(string: "https://example.com/a/b"))

    #expect(remote.relativePath(from: base) == nil)
    #expect(base.relativePath(from: remote) == nil)
  }
}
