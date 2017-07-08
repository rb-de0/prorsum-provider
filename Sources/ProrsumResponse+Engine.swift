import HTTP
import Prorsum
import Foundation

extension EngineResponse {
    
    func makeProrsum() -> ProrsumResponse {
        
        var response = ProrsumResponse()
        response.status = ProrsumStatus(statusCode: status.statusCode)
        response.version = ProrsumVersion(major: version.major, minor: version.minor)
        
        for (key, value) in headers {
            response.headers[key.key] = value
        }
        
        switch body {
        case .chunked(let closure):
            response.headers["Transfer-Encoding"] = "chunked"
            response.body = .writer({ stream in
                let chunkStream = ChunkStream(ProrsumResponseStream(stream: stream))
                try closure(chunkStream)
            })
        case .data(let bytes):
            let data = Data(bytes: bytes)
            response.headers["Content-Length"] = data.count.description
            response.body = .buffer(data)
        }
        
        return response
    }
}
