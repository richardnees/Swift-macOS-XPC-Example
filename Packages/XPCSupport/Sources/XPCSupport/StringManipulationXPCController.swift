import Foundation

public class StringManipulationXPCController {
    private let xpcConnection = NSXPCConnection(serviceName: XPCStringManipulationServiceName)
    public var stringManipulator: XPCStringManipulationService?

    public init() {

    }
    
    deinit {
        xpcConnection.invalidate()
    }

    public func setup(xpcErrorHandler: @escaping ((Error) -> Void)) {
        xpcConnection.remoteObjectInterface = NSXPCInterface(with: XPCStringManipulationService.self)
        xpcConnection.resume()

        xpcConnection.interruptionHandler = {
            xpcErrorHandler(StringManipulationXPCError.connectionInterrupted)
        }

        xpcConnection.invalidationHandler = {
            xpcErrorHandler(StringManipulationXPCError.connectionInvalidated)
        }

        guard
            let xpcService = xpcConnection.remoteObjectProxyWithErrorHandler(xpcErrorHandler) as? XPCStringManipulationService
        else {
            xpcErrorHandler(StringManipulationXPCError.connectionFailure("Unable to set up XPC connection to \(xpcConnection)"))
            return
        }

        stringManipulator = xpcService
    }
}

extension StringManipulationXPCController {
    public enum StringManipulationXPCError: Error {
        case connectionInterrupted
        case connectionInvalidated
        case connectionFailure(String)
    }
}
