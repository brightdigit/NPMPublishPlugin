import Foundation
import Publish
import ShellOut

// swiftlint:disable explicit_acl
#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif
extension URL {
  /// Returns a relative path from this URL to the given base URL.
  ///
  /// - Parameter base: The base URL from which to build the relative path.
  /// - Returns: A relative path from this URL to the given base URL, or `nil` if the two URLs are not related.
  func relativePath(from base: URL) -> String? {
    // Ensure that both URLs represent files:
    guard isFileURL, base.isFileURL else {
      return nil
    }

    // Remove/replace "." and "..", make paths absolute:
    let destComponents = standardized.pathComponents
    let baseComponents = base.standardized.pathComponents

    let index = (zip(baseComponents, destComponents).enumerated().first { element in
      element.element.0 != element.element.1
    }?.offset ?? min(baseComponents.count, destComponents.count))

    // Build relative path:
    var relComponents = Array(repeating: "..", count: baseComponents.count - index)
    relComponents.append(contentsOf: destComponents[index...])
    return relComponents.joined(separator: "/")
  }
}

// swiftlint:enable explicit_acl
