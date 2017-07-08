import Vapor

public final class Provider: Vapor.Provider {
    
    public static let repositoryName = "prorsum-provider"
    
    public init(config: Config) throws {}
    
    public func boot(_ config: Config) throws {
        config.addConfigurable(server: ProrsumServer.self, name: "prorsum")
    }
    
    public func boot(_ droplet: Droplet) throws {}
    
    public func beforeRun(_ droplet: Droplet) throws {}
    
}
