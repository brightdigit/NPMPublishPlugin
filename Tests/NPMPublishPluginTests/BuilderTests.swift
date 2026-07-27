import Publish
import Testing

@testable import NPMPublishPlugin

@Suite("NPM Builders")
internal struct BuilderTests {
  @Test("ArgumentBuilder wraps a single argument")
  internal func argumentBuilderWrapsSingleArgument() {
    let result = NPM.ArgumentBuilder.buildExpression(.string("--yes"))

    #expect(result.count == 1)
    guard case .string(let value) = result[0] else {
      Issue.record("expected .string case")
      return
    }
    #expect(value == "--yes")
  }

  @Test("ArgumentBuilder wraps an output path as a path argument")
  internal func argumentBuilderWrapsOutputPathAsPathArgument() {
    let path: OutputPath = .file(.init("a.css"))

    let result = NPM.ArgumentBuilder.buildExpression(path)

    #expect(result.count == 1)
    guard case .path(let wrapped) = result[0] else {
      Issue.record("expected .path case")
      return
    }
    #expect(wrapped == path)
  }

  @Test("ArgumentBuilder block flattens its components")
  internal func argumentBuilderBlockFlattensComponents() {
    let result = NPM.ArgumentBuilder.buildBlock(
      [.string("a")],
      [.string("b"), .string("c")]
    )

    #expect(result.count == 3)
  }

  @Test("JobBuilder collects jobs in order")
  internal func jobBuilderCollectsJobs() {
    let jobs = NPM.JobBuilder.buildBlock(
      .init(subcommand: .ci),
      .init(subcommand: .run)
    )

    #expect(jobs.count == 2)
    #expect(jobs[0].subcommand.string == "ci")
    #expect(jobs[1].subcommand.string == "run")
  }

  @Test("Job builder initializer applies the ArgumentBuilder")
  internal func jobBuilderInitAppliesArgumentBuilder() {
    let job = NPM.Job(subcommand: .run) {
      "--silent"
      OutputPath.file(.init("out.css"))
    }

    #expect(job.arguments.count == 2)
  }
}
