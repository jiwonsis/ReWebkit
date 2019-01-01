import Nimble
import Quick
import RxCocoa
import RxSwift
import Foundation
import WebKit

@testable import ReWebKit

enum httpError: Error {
    case notFound
}

class WKNavigationDelegateEventSpec: QuickSpec {
    
    
    override func spec() {
        
        let disposeBag = DisposeBag()
        let actor = ReWebView()
        
        describe("WKUIDelegateEvent Testing") {
            
            context("Initiating the Navigation Event Test") {
                it("should be calling method. when the webview load web Content.") {
                    let htmlString = "<h1 class=\"title\">title</h1l"
                    var didCommitCallBack = ""
                    var didStartProvisionalNavigationCallBack = ""
                    
                    actor.loadHTMLString(htmlString, baseURL: nil)
                    
                    DispatchQueue.main.async {
                        actor.rx.didCommit
                            .subscribe(onNext: { (view, navigation) in
                                expect(view).toNot(beNil())
                                didCommitCallBack = "didCommit"
                            })
                            .disposed(by: disposeBag)
                        
                        actor.rx.didStartProvisionalNavigation
                            .subscribe(onNext: { (view, navigation) in
                                expect(view).toNot(beNil())
                                didStartProvisionalNavigationCallBack = "didStartProvisionalNavigation"
                            })
                            .disposed(by: disposeBag)
                    }
                    
//                    expect(didStartProvisionalNavigationCallBack).toEventually(equal("didStartProvisionalNavigation"), timeout: 3.0)
//                    expect(didCommitCallBack).toEventually(equal("didCommit"), timeout: 3.0)
                    
                }
            }
            
            context("Responding to Server Actions Event Test") {
                it("should be call method. when the web view a server redirect") {
                    let htmlString = "<h1 class=\"title\">title</h1l"
                    var didReceiveServerRedirectForProvisionalNavigationCallBack = ""
                    
                    actor.loadHTMLString(htmlString, baseURL: nil)
                    
                    DispatchQueue.main.async {
                        
                        actor.rx
                            .didReceiveServerRedirectForProvisionalNavigation
                            .subscribe(onNext: { (view, navigation) in
                                expect(view).toNot(beNil())
                                didReceiveServerRedirectForProvisionalNavigationCallBack = "didReceiveServerRedirectForProvisionalNavigationCallBac"
                            })
                            .disposed(by: disposeBag)

                    }
                    
//                    expect(didReceiveServerRedirectForProvisionalNavigationCallBack)
//                        .toEventually(equal("didReceiveServerRedirectForProvisionalNavigationCallBac"), timeout: 3.0)
                    
                }
            }
            
            
            context("WKNavigation DidFinish Delegate Event Test") {
                

                it("Should be call mehtod. if html event from delegate") {
                    
                    let htmlString = "<h1 class=\"title\">title</h1l"
                    
                    
                    var didFinishCallBack = ""
                    var didFailCallBack = ""
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        actor.rx.didFinish
                            .subscribe(onNext: { (view, navigation) in
                                expect(view).toNot(beNil())
                                didFinishCallBack = "didFinish"
                            })
                            .disposed(by: disposeBag)
                        
                        actor.rx.didFail
                            .subscribe(onNext: { (_, _, error) in
                                expect(error).toNot(beNil())
                                didFailCallBack = "didFail"
                                
                            })
                            .disposed(by: disposeBag)
                    }
                     actor.loadHTMLString(htmlString, baseURL: nil)
                    
                   
                    expect(didFinishCallBack).toEventually(equal("didFinish"), timeout: 3.0)
//                      expect(didFailCallBack).toEventually(equal("didFail"), timeout: 3.0)
                    
                }
            }
            
        }
    }
}

