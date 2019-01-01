import Nimble
import Quick
import RxCocoa
import RxSwift
import WebKit

@testable import ReWebKit

class RxWKUIDelegateProxySpec: QuickSpec {
    
    override func spec() {
        describe("RxWKUIDelegateProxy Tesing") {
            context("WKWebView UIDelegate testing") {
                
                let viewMock = ReWebView(frame: .zero)
                let uiDelegateMock = WKUIDelegateMock()
                
                it("Should be nil. if WKUIDelegate not set in mock") {
                    let expected = RxWKUIDelegateProxy.currentDelegate(for: viewMock)
                    expect(expected).to(beNil())
                }
                
                it("Should not be nil. if init mehod called") {
                    
                    let acture = ReWebView(frame: .zero)
                    let expected = RxWKUIDelegateProxy(parantObject: acture)
                    expect(expected).toNot(beNil())
                }
                
                it("Should not be nil. if WKUIDelegate set in mock") {
                    
                    let acture = ReWebView(frame: .zero)
                    let _ =  RxWKUIDelegateProxy.setCurrentDelegate(uiDelegateMock, to: acture)
                    expect(acture).toNot(beNil())
                }
            }
        }
        
        
    }
}





