import Foundation
import Publish
import Testing

import struct Files.Folder

@testable import NPMPublishPlugin

@Suite("NPM Job")
internal struct JobTests {
  @Test("Designated initializer stores its values")
  internal func designatedInitStoresValues() {
    let path: OutputPath = .file(.init("a.css"))
    let job = NPM.Job(
      subcommand: .run,
      outputRelativePaths: [path],
      arguments: [.string("--silent")]
    )

    #expect(job.subcommand.string == "run")
    #expect(job.outputRelativePaths == [path])
    #expect(job.arguments.count == 1)
  }

  @Test("ci() helper builds the ci subcommand")
  internal func ciHelperBuildsCISubcommand() {
    let job = ci()

    #expect(job.subcommand.string == "ci")
    #expect(job.outputRelativePaths.isEmpty)
    #expect(job.arguments.isEmpty)
  }

  @Test("run() helper builds the run subcommand with paths and arguments")
  internal func runHelperBuildsRunSubcommandWithPathsAndArguments() {
    let path: OutputPath = .folder(.init("dist"))
    let job = NPMPublishPlugin.run(paths: [path]) {
      "--prod"
    }

    #expect(job.subcommand.string == "run")
    #expect(job.outputRelativePaths == [path])
    #expect(job.arguments.count == 1)
  }

  @Test("createOutput maps paths to their relative paths")
  internal func createOutputMapsPathsToRelativePaths() throws {
    let fileName = UUID().uuidString
    let path: OutputPath = .file(.init(fileName))
    let job = NPM.Job(subcommand: .run, outputRelativePaths: [path])

    let map = try job.createOutput(
      using: MockPublishingContextable(),
      relativeTo: .temporary
    )

    #expect(map[path] == fileName)
  }
}
