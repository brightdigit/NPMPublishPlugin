import Testing

@testable import NPMPublishPlugin

@Suite("NPM Command")
internal struct CommandTests {
  @Test("Predefined commands expose their strings")
  internal func predefinedCommands() {
    #expect(NPM.Command.ci.string == "ci")
    #expect(NPM.Command.run.string == "run")
  }

  @Test("Initializer stores the command string")
  internal func initWithString() {
    #expect(NPM.Command("install").string == "install")
  }

  @Test("String literal initializer stores the command string")
  internal func stringLiteralInit() {
    let command: NPM.Command = "test"

    #expect(command.string == "test")
  }
}
