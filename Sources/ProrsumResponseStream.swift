import Prorsum
import Transport

final class ProrsumResponseStream: WriteableStream {
    
    var isClosed = false
    
    func write(max: Int, from buffer: Bytes) throws -> Int {
        try stream.write(buffer)
        return buffer.count
    }
    
    let stream: WritableStream
    
    init(stream: WritableStream) {
        self.stream = stream
        self.isClosed = false
    }
    
    func setTimeout(_ timeout: Double) throws {}
    
    func close() throws {
        isClosed = true
    }
}
