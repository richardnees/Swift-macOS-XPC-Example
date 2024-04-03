import Foundation
import XPCSupport

public class StringManipulation: NSObject {
}

extension StringManipulation: XPCStringManipulationService {
    public func uppercase(_ string: String, with reply: @escaping (String) -> Void) {
        reply(string.uppercased())
    }

    public func uppercase(_ string: String) async -> String {
        await withCheckedContinuation { continuation in
            uppercase(string) { reply in
                continuation.resume(returning: reply)
            }
        }
    }

    public func lowercase(_ string: String, with reply: @escaping (String) -> Void) {
        reply(string.lowercased())
    }

    public func lowercase(_ string: String) async -> String {
        await withCheckedContinuation { continuation in
            lowercase(string) { reply in
                continuation.resume(returning: reply)
            }
        }
    }

    public func capitalize(_ string: String, with reply: @escaping (String) -> Void) {
        reply(string.capitalized)
    }

    public func capitalize(_ string: String) async -> String {
        await withCheckedContinuation { continuation in
            capitalize(string) { reply in
                continuation.resume(returning: reply)
            }
        }
    }
}
