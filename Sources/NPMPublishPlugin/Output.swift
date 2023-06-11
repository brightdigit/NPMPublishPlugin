import struct Files.File
import struct Files.Folder
import Foundation

/// A protocol that defines an output object used by `PublishingContext`.
public protocol Output {
  /// The URL of the output object.
  var url: URL { get }
}

extension Files.File: Output {}

extension Folder: Output {}
