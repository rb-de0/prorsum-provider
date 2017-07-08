import HTTP
import Prorsum
import URI

extension ProrsumRequest {
    
    func makeEngine() throws -> EngineRequest {
        
        let engineUri = try URI(url.absoluteString)
        
        let engineVersion = EngineVersion(
            major: version.major,
            minor: version.minor,
            patch: 0
        )
        
        var engineHeaders: [HeaderKey: String] = [:]
        
        headers.forEach {
            let key = HeaderKey($0.key.string)
            engineHeaders[key] = $0.value
        }
        
        let engineBody: EngineBody
        
        switch body {
        case .buffer(let data):
            engineBody = .data(data.bytes)
        default:
            engineBody = .data([])
        }
        
        return EngineRequest(
            method: EngineMethod(String(describing: method)),
            uri: engineUri,
            version: engineVersion,
            headers: engineHeaders,
            body: engineBody
        )
    }
}
