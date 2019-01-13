import WebKit

public class ReWebView: WKWebView {
    
    public init() {
        let configuration = WKWebViewConfiguration();
        super.init(frame: .zero, configuration: configuration)
    }
    
    public init(frame: CGRect) {
        let configuration = WKWebViewConfiguration();
        super.init(frame: frame, configuration: configuration)
    }
    
    // fatalErorr testing does not support Nimble framework. at swift cli
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func load(_ url: String) {
        let url = URL(string: url)!
        self.load(URLRequest(url: url))
    }
}
