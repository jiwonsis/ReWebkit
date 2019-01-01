import Nimble
import Quick
import RxCocoa
import RxSwift
import WebKit

@testable import ReWebKit

class RxWKNavigationDelegateProxySpec: QuickSpec {
    
    override func spec() {
        describe("RxWKNavigationDelegate Tesing") {
            context("WKWebView NavigationDelegate testing") {
                
                let viewMock = ReWebView(frame: .zero)
                let navigationMock = WKNavigationDelegateMock()
                
                it("Should be nil. if WKUIDelegate not set in mock") {
                    let expected = RXWkNavigationDelegateProxy.currentDelegate(for: viewMock)
                    expect(expected).to(beNil())
                }
                
                it("Should not be nil. if init method called") {
                    
                    let actor = ReWebView(frame: .zero)
                    let _ = RXWkNavigationDelegateProxy(parentObject: actor)
                    expect(actor).toNot(beNil())
                }
                
                it("Should not be nil. if WKUIDelegate set in mock") {
                    
                    let _ =  RXWkNavigationDelegateProxy.setCurrentDelegate(navigationMock, to: viewMock)
                    let expected = RXWkNavigationDelegateProxy.currentDelegate(for: viewMock)
                    
                    expect(expected).toNot(beNil())
                }
            }
        }
        
        
    }
}



