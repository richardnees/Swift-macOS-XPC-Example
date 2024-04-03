import Foundation

public class XPCController<T> {
    public let connection: NSXPCConnection
    public let interface: NSXPCInterface
    public private(set) var service: T?

    public init(
        connection: NSXPCConnection,
        interface: NSXPCInterface
    ) {
        self.connection = connection
        self.interface = interface
    }
    
    deinit {
        connection.invalidate()
    }

    public func setup(errorHandler: @escaping ((Error) -> Void)) {
        connection.remoteObjectInterface = interface
        connection.resume()

        connection.interruptionHandler = {
            errorHandler(XPCError.connectionInterrupted)
        }

        connection.invalidationHandler = {
            errorHandler(XPCError.connectionInvalidated)
        }

        guard
            let xpcService = connection.remoteObjectProxyWithErrorHandler(errorHandler) as? T
        else {
            errorHandler(XPCError.connectionFailure("Unable to set up XPC connection to \(connection)"))
            return
        }

        service = xpcService
    }
}

extension XPCController {
    public enum XPCError: Error {
        case connectionInterrupted
        case connectionInvalidated
        case connectionFailure(String)
    }
}
