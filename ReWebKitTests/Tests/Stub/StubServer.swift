import Foundation
import Swifter

class StubServer {
    static let shared = StubServer()
    private init() {}
    
    let server = HttpServer()
    
    
    // find the stub key in env property
    func getStubInfo() -> (needStub: Bool, url: String) {
        let env = ProcessInfo.processInfo.environment
        if let value = env["STUB"] {
            return (needStub: true, url: value)
        }
        
        return (needStub: false, url: "")
    }
    
    func startServer() {
        guard let resourcePath = Bundle.main.resourcePath else {
            fatalError("ResourcePath could not get !!")
        }
        
        server["/:path"] = shareFile(resourcePath)
        do {
            try server.start(9080)
        } catch {
            fatalError("Swifter server does not started")
        }
    }
    
    func stopServer() {
        server.stop()
    }
}

struct StubServerInfo {
    let url: String
    let htmlData: Data
}
