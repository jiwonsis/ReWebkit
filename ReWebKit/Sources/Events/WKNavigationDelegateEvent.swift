import RxCocoa
import RxSwift
import WebKit

extension Reactive where Base: ReWebView {
    
    public typealias DecidePolicyNavigationEvent = (webView: ReWebView, navigationAction: WKNavigationAction, handler: (WKNavigationActionPolicy) -> Void)
    public typealias NavigationActionPolicyEvent = (webView: ReWebView, navigationResponse: WKNavigationResponse, handler: (WKNavigationResponsePolicy) -> Void)
    
    public typealias ChallengeHandler = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    public typealias DidReceiveChallengeEvent = (webView: ReWebView, challenge: URLAuthenticationChallenge, handler: ChallengeHandler)
    
    public typealias NavigationEvent = (webView: ReWebView, naviation: WKNavigation)
    public typealias NavigationFailEvent = (webView: ReWebView, navigation: WKNavigation, error: Error)
    
    public var delegate : DelegateProxy<ReWebView, WKNavigationDelegate> {
        return RXWkNavigationDelegateProxy.proxy(for: base)
    }
    
    
    // Decides whether to allow or cancel a navigation.
    public var decidePolicyNavigation: ControlEvent<DecidePolicyNavigationEvent> {
        typealias __ActionHandler = @convention(block) (WKNavigationActionPolicy) -> ()
        let source: Observable<DecidePolicyNavigationEvent> = delegate
            .methodInvoked(.decidePolicyNavigationAction)
            .map{ args in
                let view = args[0] as! ReWebView
                let action = args[1] as! WKNavigationAction
                var closureObject: AnyObject? = nil
                var mutableArgs = args
                mutableArgs.withUnsafeMutableBufferPointer { ptr in
                    closureObject = ptr[2] as AnyObject
                }
                let __actionBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObject as AnyObject).toOpaque())
                let handler = unsafeBitCast(__actionBlockPtr, to: __ActionHandler.self)
                return (view, action, handler)
            }
        return ControlEvent(events: source)
    }
    
    // Decides whether to allow or cancel a navigation after its response is known.
    public var decidePolicyNavigationResponse: ControlEvent<NavigationActionPolicyEvent> {
        typealias __ActionHandler = @convention(block) (WKNavigationResponsePolicy) -> ()
        let source: Observable<NavigationActionPolicyEvent> = delegate
            .methodInvoked(.decidePolicyNavigationResponse)
            .map{ args in
                let view = args[0] as! ReWebView
                let action = args[1] as! WKNavigationResponse
                var closureObject: AnyObject? = nil
                var mutableArgs = args
                mutableArgs.withUnsafeMutableBufferPointer { ptr in
                    closureObject = ptr[2] as AnyObject
                }
                let __actionBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObject as AnyObject).toOpaque())
                let handler = unsafeBitCast(__actionBlockPtr, to: __ActionHandler.self)
                return (view, action, handler)
            }
        return ControlEvent(events: source)
    }
    
    // Called when web content begins to load in a web view.
    public var didStartProvisionalNavigation: ControlEvent<NavigationEvent> {
        let source: Observable<NavigationEvent> = delegate
            .methodInvoked(.didStartProvisionlNavigation)
            .map(navigationEventWith)
        return ControlEvent(events: source)
    }
    
    //Called when a web view receives a server redirect.
    public var didReceiveServerRedirectForProvisionalNavigation: ControlEvent<NavigationEvent> {
        let sources: Observable<NavigationEvent> = delegate
            .methodInvoked(.didReceiveServerRedirectForProvisionalNavigation)
            .map(navigationEventWith)
        
        return ControlEvent(events: sources)
    }
    
    // Called when an error occurs while the web view is loading content.
    public var didFailProvisionalNavigation: ControlEvent<NavigationFailEvent> {
        let source: Observable<NavigationFailEvent> = delegate
            .methodInvoked(.didFailProvisionalNavigation)
            .map(navigationFailEventWith)
        return ControlEvent(events: source)
    }
    
    // Called when the webView begins to receive webContent
    public var didCommit: ControlEvent<NavigationEvent> {
        let source: Observable<NavigationEvent> = delegate
            .methodInvoked(.didCommit)
            .map(navigationEventWith)
        return ControlEvent(events: source)
    }

    // Called when the navigation is complete.
    public var didFinish: ControlEvent<NavigationEvent> {
        let source: Observable<NavigationEvent> = delegate
            .methodInvoked(.didFinish)
            .map(navigationEventWith)

        return ControlEvent(events: source)
    }

    // Called when an error occurs during navigation.
    // I don't know how write test case
    public var didFail: ControlEvent<NavigationFailEvent> {
        let source: Observable<NavigationFailEvent> = delegate
            .methodInvoked(.didFail)
            .map(navigationFailEventWith)

        return ControlEvent(events: source)
    }
    
    // Called when the web view needs to respond to an authentication challenge.
    // I don't know how write test case
    public var didReceiveChallenge: ControlEvent<DidReceiveChallengeEvent> {
        typealias __ChanlengeHandler = @convention(block) (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        let sources: Observable<DidReceiveChallengeEvent> = delegate
            .sentMessage(.didReceiveChallenge)
            .map { arg in
                let view = arg[0] as! ReWebView
                let challenge = arg[1] as! URLAuthenticationChallenge
                var closureObj: AnyObject? = nil
                let mutableArg = arg
                mutableArg.withUnsafeBufferPointer{ ptr in
                    closureObj = ptr[2] as AnyObject
                }
                
                let __challengeBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObj as AnyObject).toOpaque())
                
                let hander = unsafeBitCast(__challengeBlockPtr, to: __ChanlengeHandler.self)
                
                return (view, challenge, hander)
            }
        
        return ControlEvent(events: sources)
    }

    
    private func navigationEventWith(_ arg: [Any]) -> NavigationEvent {
        let view = arg.first as! ReWebView
        let navigation = arg.last as! WKNavigation
        
        return (view, navigation)
    }
    
    private func navigationFailEventWith(_ arg: [Any]) -> NavigationFailEvent {
        let view = arg[0] as! ReWebView
        let navigation = arg[1] as! WKNavigation
        let error = arg[2] as! Error
        
        return (view, navigation, error)
    }
    
    
}

private extension Selector {
    static let decidePolicyNavigationAction = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationAction, @escaping(WKNavigationActionPolicy) -> Void) -> Void)?)
    static let decidePolicyNavigationResponse = #selector(WKNavigationDelegate.webView(_:decidePolicyFor:decisionHandler:) as ((WKNavigationDelegate) -> (WKWebView, WKNavigationResponse, @escaping(WKNavigationResponsePolicy) -> Void) -> Void)?)
    static let didStartProvisionlNavigation = #selector(WKNavigationDelegate.webView(_:didStartProvisionalNavigation:))
    static let didReceiveServerRedirectForProvisionalNavigation = #selector(WKNavigationDelegate.webView(_:didReceiveServerRedirectForProvisionalNavigation:))
    static let didFailProvisionalNavigation = #selector(WKNavigationDelegate.webView(_:didFailProvisionalNavigation:withError:))
    static let didCommit = #selector(WKNavigationDelegate.webView(_:didCommit:))
    static let didFinish = #selector(WKNavigationDelegate.webView(_:didFinish:))
    static let didFail = #selector(WKNavigationDelegate.webView(_:didFail:withError:))
    static let didReceiveChallenge = #selector(WKNavigationDelegate.webView(_:didReceive:completionHandler:))
}
