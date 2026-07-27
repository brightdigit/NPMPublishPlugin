import Publish
import Testing

@testable import NPMPublishPlugin

@Suite("NPM Argument")
internal struct ArgumentTests {
  @Test("String argument returns its value unchanged")
  internal func stringArgumentReturnsValueUnchanged() {
    let argument: NPM.Argument = .string("--yes")

    #expect(argument.relativePath(basedOn: [:]) == "--yes")
  }

  @Test("String literal initializer produces a .string case")
  internal func stringLiteralInitProducesStringCase() {
    let argument: NPM.Argument = "--flag"

    guard case .string(let value) = argument else {
      Issue.record("expected .string case")
      return
    }
    #expect(value == "--flag")
  }

  @Test("Path argument resolves and quotes the mapped value")
  internal func pathArgumentResolvesAndQuotesMappedValue() {
    let path: OutputPath = .file(.init("output.css"))
    let map: [OutputPath: String] = [path: "build/output.css"]
    let argument: NPM.Argument = .path(path)

    #expect(argument.relativePath(basedOn: map) == "\"build/output.css\"")
  }

  @Test("Path argument falls back to the quoted default when missing")
  internal func pathArgumentFallsBackToQuotedDefaultWhenMissing() {
    let path: OutputPath = .folder(.init("dist"))
    let argument: NPM.Argument = .path(path)

    #expect(argument.relativePath(basedOn: [:]) == "\"\"")
    #expect(
      argument.relativePath(basedOn: [:], withDefaultValue: "fallback") == "\"fallback\""
    )
  }
}
