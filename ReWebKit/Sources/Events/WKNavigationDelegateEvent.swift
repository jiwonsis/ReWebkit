import RxCocoa
import RxSwift
import WebKit

extension Reactive where Base: ReWebView {
    
    public typealias DidCommitEvent = (webview: ReWebView, navigation: WKNavigation)
    public typealias DidStartProvisionalNavigationEvent = (webView: ReWebView, naviation: WKNavigation)
    public typealias didReceiveServerRedirectForProvisionalNavigationEvent = (webView: ReWebView, navigation: WKNavigation)
    public typealias DidFinishEvent = (webView: ReWebView, navigation: WKNavigation)
    public typealias DidFailEvent = (webView: ReWebView, navigation: WKNavigation, error: Error)
    
    public var naviationDelegate : DelegateProxy<ReWebView, WKNavigationDelegate> {
        return RXWkNavigationDelegateProxy.proxy(for: base)
    }
    
    // Called when the webView begins to receive webContent
    public var didCommit: ControlEvent<DidCommitEvent> {
        let source: Observable<DidCommitEvent> = naviationDelegate
            .methodInvoked(.didCommit)
            .map{ args in
                let view = args[0] as! ReWebView
                let navigation = args[1] as! WKNavigation
                
                return (view, navigation)
            }
        return ControlEvent(events: source)
    }
    
    // Called when web content begins to load in a web view.
    public var didStartProvisionalNavigation: ControlEvent<DidStartProvisionalNavigationEvent> {
        let sources: Observable<DidStartProvisionalNavigationEvent> = naviationDelegate
            .methodInvoked(.didStartProvisionlNavigation)
            .map{ args in
                let view = args[0] as! ReWebView
                let navigation = args[1] as! WKNavigation
                
                return (view, navigation)
            }
        
        return ControlEvent(events: sources)
    }
    
    //Called when a web view receives a server redirect.
    public var didReceiveServerRedirectForProvisionalNavigation: ControlEvent<didReceiveServerRedirectForProvisionalNavigationEvent> {
        let sources: Observable<didReceiveServerRedirectForProvisionalNavigationEvent> = naviationDelegate
            .methodInvoked(.didReceiveServerRedirectForProvisionalNavigation)
            .map{ args in
                let view = args[0] as! ReWebView
                let navigation = args[1] as! WKNavigation
                
                return (view, navigation)
            }
        
        return ControlEvent(events: sources)
    }
    
    
    // Called when the webView  web content finished
    public var didFinish: ControlEvent<DidFinishEvent> {
        let source: Observable<DidFinishEvent> = naviationDelegate
            .methodInvoked(.didFinish)
            .map{ args in
                let view = args[0] as! ReWebView
                let navigation = args[1] as! WKNavigation
                
                return (view, navigation)
            }
        
        return ControlEvent(events: source)
    }
    
    // Called Loading web content Fail
    public var didFail: ControlEvent<DidFailEvent> {
        let source: Observable<DidFailEvent> = naviationDelegate
            .methodInvoked(.didFail)
            .map{ args in
                let view = args[0] as! ReWebView
                let navigation = args[1] as! WKNavigation
                let error = args[2] as! Error
                
                return (view, navigation, error)
            }
        
        return ControlEvent(events: source)
    }
    
    
}

private extension Selector {
    static let didCommit = #selector(WKNavigationDelegate.webView(_:didCommit:))
    static let didStartProvisionlNavigation = #selector(WKNavigationDelegate.webView(_:didStartProvisionalNavigation:))
    static let didReceiveServerRedirectForProvisionalNavigation = #selector(WKNavigationDelegate.webView(_:didReceiveServerRedirectForProvisionalNavigation:))
    static let didFinish = #selector(WKNavigationDelegate.webView(_:didFinish:))
    static let didFail = #selector(WKNavigationDelegate.webView(_:didFail:withError:))
}
