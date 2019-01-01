import WebKit
import RxCocoa
import RxSwift

public typealias RxWkNavigationDelegate = DelegateProxy<ReWebView, WKNavigationDelegate>

public class RXWkNavigationDelegateProxy: RxWkNavigationDelegate, DelegateProxyType, WKNavigationDelegate {
    
    public weak private(set) var webView: ReWebView?
    
    public init(parentObject: ParentObject) {
        webView = parentObject
        
        super.init(parentObject: parentObject, delegateProxy: RXWkNavigationDelegateProxy.self)
    }
    
    // this method only calling own file.
    // Should call it from concrete DelegateProxy type, not generic.
    public static func registerKnownImplementations() {
        self.register{
            RXWkNavigationDelegateProxy(parentObject: $0)
        }
    }
    
    public static func currentDelegate(for object: ReWebView) -> WKNavigationDelegate? {
        return object.navigationDelegate
    }
    
    public static func setCurrentDelegate(_ delegate: WKNavigationDelegate?, to object: ReWebView) {
        object.navigationDelegate = delegate
    }
    
    
    
    
    
}
