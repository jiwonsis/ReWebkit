import WebKit
import RxSwift
import RxCocoa

public typealias RxWKUIDelegate = DelegateProxy<ReWebView, WKUIDelegate>

public class RxWKUIDelegateProxy: RxWKUIDelegate, DelegateProxyType, WKUIDelegate {
    
    public weak private(set) var webView: ReWebView?
    
    public init(parantObject parentObject: ParentObject) {
        webView = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxWKUIDelegateProxy.self)
    }
    
    
    // this method only calling own file.
    // Should call it from concrete DelegateProxy type, not generic.
    public static func registerKnownImplementations() {
        self.register{
            RxWKUIDelegateProxy(parantObject: $0)
        }
    }
    
    public static func currentDelegate(for object: ReWebView) -> WKUIDelegate? {
        return object.uiDelegate
    }
    
    public static func setCurrentDelegate(_ delegate: WKUIDelegate?, to object: ReWebView) {
        object.uiDelegate = delegate
    }
    
    
}
