import Testing

@testable import NPMPublishPlugin

@Suite("NPM Invocation Error")
internal struct NPMInvocationErrorTests {
  @Test("Description formats command, status, and standard error")
  internal func descriptionFormatsCommandStatusAndStandardError() {
    let error = NPMInvocationError(
      command: "cd /tmp && npm ci",
      terminationStatus: .exited(1),
      standardError: "boom"
    )

    #expect(
      error.description
        == "npm command failed (\(error.terminationStatus)): cd /tmp && npm ci\nboom"
    )
  }
}
