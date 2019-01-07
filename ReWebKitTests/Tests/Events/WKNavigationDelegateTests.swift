import XCTest
import RxSwift
import RxBlocking
import WebKit

@testable import ReWebKit

enum httpError: Error {
    case notFound
}

class WKNavigationDelegateTests: XCTestCase {
    
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
extension WKNavigationDelegateTests {
    
    func test_ShouldBeCalledDecidePolicyNavigation() {
        
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        
        actor.rx.decidePolicyNavigation
            .bind{ (view, action, handler) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(action, "WKNavigationAction is nil")
                expectation.fulfill()
                handler(.allow)
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDecidePolicyNavigationResponse() {
        
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        
        actor.rx.decidePolicyNavigationResponse
            .bind{ (view, response, handler) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(response, "WKNavigationResponse is nil")
                expectation.fulfill()
                handler(.allow)
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidStartProvisionalNavigationEvent() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        
        actor.rx.didStartProvisionalNavigation
            .bind{ (view, navigation) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(navigation, "WKNavigation is nil")
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidReceiveServerRedirectForProvisionalNavigation() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/redirect")
        
        actor.rx.didReceiveServerRedirectForProvisionalNavigation
            .bind{ (view, navigation) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(navigation, "WKNavigation is nil")
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func test_ShouldBeCalledDidFailProvisionalNavigation() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/fail")
        stubServer.tearDown()
        
        actor.rx.didFailProvisionalNavigation
            .bind{ (view, navigation, error) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(navigation, "WKNavigation is nil")
                XCTAssertNotNil(error, "Error is nil")
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidCommit() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        
        actor.rx.didCommit
            .bind{ (view, navigation) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(navigation, "WKNavigation is nil")
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShouldBeCalledDidFinish() {
        let expectation = XCTestExpectation(description: "event call")
        
        actor.load("http://localhost:7000/default")
        
        actor.rx.didFinish
            .bind{ (view, navigation) in
                XCTAssertNotNil(view, "ReWebView is nil")
                XCTAssertNotNil(navigation, "WKNavigation is nil")
                expectation.fulfill()
            }.disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
