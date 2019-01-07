import WebKit
import RxSwift
import RxCocoa

extension Reactive where Base: ReWebView {
    
    public typealias JSAlertEvent = (webView: ReWebView, message: String, frame: WKFrameInfo, handler: () -> ())
    public typealias JSConfirmEvent = (webView: WKWebView, message: String, frame: WKFrameInfo, handler: (Bool) -> ())
    public typealias JSDidClose = (ReWebView)
    
    public var uiDelegate: DelegateProxy<ReWebView, WKUIDelegate> {
        return RxWKUIDelegateProxy.proxy(for: base)
    }
    
    public var javascriptAlertPanel: ControlEvent<JSAlertEvent> {
        typealias __CompletionHandler = @convention(block) () -> ()
        let source: Observable<JSAlertEvent>  = uiDelegate
            .methodInvoked(.jsAlert)
            .map{ args in
                
                let view = args[0] as! ReWebView
                let message = args[1] as! String
                let frame = args[2] as! WKFrameInfo
                var closureObject: AnyObject? = nil
                var mutableArgs = args
                mutableArgs.withUnsafeMutableBufferPointer { ptr in
                    closureObject = ptr[3] as AnyObject
                }
                let __completionBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObject as AnyObject).toOpaque())
                let handler = unsafeBitCast(__completionBlockPtr, to: __CompletionHandler.self)
                
                return (view, message, frame, handler)
        }
        
        return ControlEvent(events: source)
    }
    
    public var javaScriptConfirmPanel: ControlEvent<JSConfirmEvent> {
        typealias __ConfirmHandler = @convention(block) (Bool) -> ()
        let source: Observable<JSConfirmEvent> = uiDelegate
            .methodInvoked(.jsConfirm)
            .map{ args in
                let view = args[0] as! WKWebView
                let message = args[1] as! String
                let frame = args[2] as! WKFrameInfo
                var closureObject: AnyObject? = nil
                var mutableArgs = args
                mutableArgs.withUnsafeMutableBufferPointer { ptr in
                    closureObject = ptr[3] as AnyObject
                }
                let __confirmBlockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(closureObject as AnyObject).toOpaque())
                let handler = unsafeBitCast(__confirmBlockPtr, to: __ConfirmHandler.self)
                return (view, message, frame, handler)
        }
        
        return ControlEvent(events: source)
    }
    
    public var didClose: ControlEvent<JSDidClose> {
        let source: Observable<JSDidClose> = uiDelegate
            .methodInvoked(.jsDidClose)
            .map{ args in
                let view = args[0] as! ReWebView
                return view
        }
        
        return ControlEvent(events: source)
    }
}

private extension Selector {
    static let jsAlert = #selector(WKUIDelegate.webView(_:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:))
    static let jsConfirm = #selector(WKUIDelegate.webView(_:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:))
    static let jsDidClose = #selector(WKUIDelegate.webViewDidClose(_:))
}
