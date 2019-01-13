import Foundation
import Swifter

class StubServer {
    
    let server = HttpServer()
    
    func setUp() {
        stubSetup()
        try! server.start(7000)
        
    }
    
    func tearDown() {
        server.stop()
    }
    
    func getUrl() -> String {
        return "http://localhost:7000"
    }
    
    func stubSetup() {
        
        let successServerInfo = StubServerInfo(url: "/default", htmlString: defaulHTMLData())
        let successResponse: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.html(successServerInfo.htmlString))
        }
        server.GET[successServerInfo.url] = successResponse
        
        let redirectionServerInfo = StubServerInfo(url: "/redirect", htmlString: "")
        server[redirectionServerInfo.url] = { req in
            return .movedPermanently("/default")
        }
        
        let failServerInfo = StubServerInfo(url: "/fail", htmlString: "")
        server[failServerInfo.url] = { req in
            return .forbidden
        }
    }
    
    func defaulHTMLData() -> String {
        let header = "<html><header><title>test ReWebview</title></header>"
        let body = "<body><h1 class=\"title\">title</h1><p><a href=hoge://>link</a></p></body>"
        let end = "</html>"
        return header + body + end
    }
}

struct StubServerInfo {
    let url: String
    let htmlString: String
}
