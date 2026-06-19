import Foundation
import Publish
import Testing

import struct Files.Folder

@testable import NPMPublishPlugin

@Suite("NPM Invocation")
internal struct NPMInvocationTests {
  @Test("Builds the expected command string")
  internal func buildsExpectedCommandString() throws {
    let commandString = "npm init --yes"

    let npmCommand: NPMInvocation = try .npm(
      .init(subcommand: .init("init")) {
        .init(stringLiteral: "--yes")
      },
      withSettings: NPM.Settings(location: .folder(Folder.current)),
      andContext: MockPublishingContextable()
    )

    #expect(npmCommand.string == commandString)
  }

  @Test("Resolves arguments and output paths")
  internal func resolvesArgumentsAndOutputPaths() throws {
    let cssName = UUID().uuidString
    let outputPath: OutputPath = .file(.init(cssName))

    let invocation: NPMInvocation = try .npm(
      .init(
        subcommand: .run,
        outputRelativePaths: [outputPath],
        arguments: [.string("build"), .path(outputPath)]
      ),
      withSettings: NPM.Settings(location: .folder(Folder.temporary)),
      andContext: MockPublishingContextable()
    )

    #expect(invocation.npmPath == "npm")
    #expect(invocation.arguments == ["run", "build", "\"\(cssName)\""])
    #expect(invocation.string == "npm run build \"\(cssName)\"")
  }
}
