import HTTP
import Foundation
import Prorsum
import Sockets
import Vapor

public final class ProrsumServer: ServerProtocol {
    
    public let hostname: String
    public let port: Sockets.Port
    public let securityLayer: SecurityLayer
    
    private var server: HTTPServer!
    
    public init(hostname: String, port: Sockets.Port, _ securityLayer: SecurityLayer) throws {
        self.hostname = hostname
        self.port = port
        self.securityLayer = securityLayer
    }
    
    public func start(_ responder: Responder, errors: @escaping ServerErrorHandler) throws {
        
        server = try HTTPServer { (request, writer) in
            
            defer {
                writer.close()
            }
            
            do {
                
                let engineRequest = try request.makeEngine()
                let response = try responder.respond(to: engineRequest)
                let prorsumResponse = response.makeProrsum()
                
                try writer.serialize(prorsumResponse)
                
            } catch {

                // TODO: Error Handling
                print(error)
            }
        }
        
        try server.bind(host: hostname, port: UInt(port))
        try server.listen()
        
        RunLoop.main.run()
    }
}
