import RxCocoa
import RxSwift
import WebKit
import Quick
import Nimble

@testable import ReWebKit

class WKUIDelegateEventSpec: QuickSpec {
    
    override func spec() {
        
         describe("WKUIDelegateEvent Testing") {
            let disposeBag = DisposeBag()
            let actor = ReWebView()

            context("javascript delegate testing") {
                it("Should be equal to expected and javascript alert message") {
                    
                    let expected = "AlertMessage!"
                    
                    actor.evaluateJavaScript("window.alert('\(expected)')", completionHandler: nil)
                    waitUntil(timeout: 3.0, action: { done in
                        actor.rx.javascriptAlertPanel
                            .debug()
                            .subscribe(onNext: { (_, message, _, completeHandler) in
                                expect(expected).to(equal(message))
                                completeHandler()
                                done()
                            })
                            .disposed(by: disposeBag)
                    })
                }
                
                it("Shoud be equal to expected and javascript confirm message") {
                    
                    let expected = "confirmMessage"
                    
                    waitUntil(timeout: 3.0, action: { done in
                        actor.rx.javaScriptConfirmPanel
                            .subscribe(onNext: { (_, message, _, completeHandler) in
                                expect(expected).to(equal(expected))
                                completeHandler(true)
                                done()
                            })
                            .disposed(by: disposeBag)
                        
                        actor.evaluateJavaScript("window.confirm('\(expected)')", completionHandler: nil)
                    })
                }
                
                
                it("Shoud not be nil. if this delegate method called") {
                   
                    waitUntil(timeout: 3.0, action: { done in
                        actor.rx.didClose
                            .subscribe(onNext: { webView in
                                
                                expect(webView).toNot(beNil())
                                done()
                            })
                            .disposed(by: disposeBag)
                        
                        actor.evaluateJavaScript(
                            "window.open('about:blink','_blank', 'menubar=yes');",
                            completionHandler: { (_,_) in
                                actor.evaluateJavaScript("window.close()", completionHandler: nil)
                        })
                    })
                }
                
                
            }
        }
    }
}
