import Foundation

@testable import ReWebKit

struct ReWebViewMock {
    
    var webView: ReWebView
    
    init() {
        let htmlString = "<h1 class=\"title\">title</h1l"
        webView = ReWebView();
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    
}
