import Nimble
import Quick
import WebKit

@testable import ReWebKit

class ReWebViewSpec: QuickSpec {
    
    override func spec() {
        describe("ReWebView Tesing") {
            context("init test") {
                it ("shoud be not nil. if uising init method") {
                    let acture = ReWebView(frame: .zero)
                    expect(acture).toNot(beNil())
                }
            }
        }
    }
}

