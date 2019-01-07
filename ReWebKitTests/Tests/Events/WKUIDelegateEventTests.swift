import XCTest
import RxSwift
import RxBlocking
import WebKit

@testable import ReWebKit


class WKUIDelegateEventTests: XCTestCase {
    
    let stubServer = StubServer()
    let disposeBag = DisposeBag()
    let actor = ReWebView()

    override func setUp() {
        stubServer.setUp()
    }

    override func tearDown() {
        actor.stopLoading()
        stubServer.tearDown()
    }
}

// Single method test
extension WKUIDelegateEventTests {
    
    func test_ShouldBeCalledJavascriptAlertPanel() {
        let expectation = XCTestExpectation(description: "event call")
        let expectedMessage = "alert"

        actor.load("http://localhost:7000/default")
        actor.rx.javascriptAlertPanel
            .bind{ (view, message, frame, handler) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(message, "String is nil")
                XCTAssertNotNil(frame, "WKFrameInfo is nil")
                XCTAssertEqual(message, expectedMessage)
                expectation.fulfill()
                handler()
            }
            .disposed(by: disposeBag)
        
        actor.evaluateJavaScript("window.alert('\(expectedMessage)')", completionHandler: nil)
        
           wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledJavaScriptConfirmPanel() {
        let expectation = XCTestExpectation(description: "event call")
        let expectedMessage = "alert"
        
        actor.load("http://localhost:7000/default")
        actor.rx.javaScriptConfirmPanel
            .bind{ (view, message, frame, handler) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(message, "String is nil")
                XCTAssertNotNil(frame, "WKFrameInfo is nil")
                XCTAssertEqual(message, expectedMessage)
                expectation.fulfill()
                handler(false)
            }
            .disposed(by: disposeBag)
        
        actor.evaluateJavaScript("window.confirm('\(expectedMessage)')", completionHandler: nil)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidClose() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        actor.rx.didClose
            .bind{ view in
                XCTAssertNotNil(view, "ReWebView is nil")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        actor.evaluateJavaScript(
            "window.open('about:blink','_blank', 'menubar=yes');",
            completionHandler: { (_,_) in
                self.actor.evaluateJavaScript("window.close()", completionHandler: nil)
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidReceiveChallenge() {
        
        let expectation = XCTestExpectation(description: "event call")
        actor.load("https://jigsaw.w3.org/HTTP/Basic/")
        
        actor.rx.didReceiveChallenge
            .bind{ (view, challenge, handler) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(challenge, "URLSession.AuthChallengeDisposition is nil")
                handler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
