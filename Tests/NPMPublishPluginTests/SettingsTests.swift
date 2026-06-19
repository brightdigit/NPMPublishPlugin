import Files
import Publish
import Testing

@testable import NPMPublishPlugin

@Suite("NPM Settings")
internal struct SettingsTests {
  @Test("npmPath defaults to \"npm\"")
  internal func npmPathDefaultsToNpm() {
    #expect(NPM.Settings(location: .folder(.temporary)).npmPath == "npm")
    #expect(NPM.Settings(folder: .temporary).npmPath == "npm")
    #expect(NPM.Settings(path: Path(".")).npmPath == "npm")
  }

  @Test("Custom npmPath is preserved")
  internal func customNpmPathIsPreserved() {
    #expect(
      NPM.Settings(npmPath: "/usr/local/bin/npm", folder: .temporary).npmPath
        == "/usr/local/bin/npm"
    )
  }

  @Test("Folder location returns the folder directly")
  internal func folderLocationReturnsFolderDirectly() throws {
    let settings = NPM.Settings(location: .folder(.temporary))

    let resolved = try settings.folder(usingContext: MockPublishingContextable())

    #expect(resolved.path == Folder.temporary.path)
  }

  @Test("Path location delegates resolution to the context")
  internal func pathLocationDelegatesToContext() throws {
    let context = FolderResolvingContext(resolved: .temporary)
    let settings = NPM.Settings(path: Path("some/where"))

    let resolved = try settings.folder(usingContext: context)

    #expect(resolved.path == Folder.temporary.path)
    #expect(context.requestedPath?.string == "some/where")
  }
}
