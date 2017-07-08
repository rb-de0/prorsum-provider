import XCTest

import Core
import HTTP
import Vapor

@testable import ProrsumProvider

class ProrsumProviderTests: XCTestCase {
    
    func testServer() throws {
        
        class TestResponder: Responder {
            
            func respond(to request: Request) throws -> Response {
                
                let response = Response(
                    status: .ok,
                    headers: ["Test": "Example Header"],
                    body: "Test Body"
                )
                
                response.cookies["Test-Session-Id"] = "prorsum-session-id"
                
                return response
            }
        }
        
        let test = TestResponder()
        let drop = try Droplet()
        
        let port = 8080
        let server = try ProrsumServer(hostname: "localhost", port: UInt16(port), .none)
        
        background {
            do {
                try server.start(test) { error in
                    XCTFail("Server error: \(error)")
                }
                
            } catch {
                XCTFail("Server failed to start: \(error)")
            }
        }
        
        drop.console.wait(seconds: 1)
        
        let response = try drop.client.get("http://127.0.0.1:\(port)")
        
        XCTAssertEqual(response.status, .ok)
        XCTAssertEqual(response.version.major, 1)
        XCTAssertEqual(response.version.minor, 1)
        XCTAssertEqual(response.version.patch, 0)
        XCTAssertEqual(response.keepAlive, true)
        
        guard case .data(let bytes) = response.body else {
            XCTFail("Incorrect body type.")
            return
        }
        
        XCTAssertEqual(bytes.makeString(), "Test Body")
        
        guard let testHeader = response.headers["Test"] else {
            XCTFail("No 'Test' header.")
            return
        }
        
        XCTAssertEqual(testHeader, "Example Header")
        
        guard let setCookieHeader = response.cookies["Test-Session-Id"] else {
            XCTFail("No Cookie")
            return
        }
        
        XCTAssertEqual(setCookieHeader, "prorsum-session-id")
        
    }

    static var allTests = [
        ("testServer", testServer),
    ]
}
