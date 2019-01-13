import XCTest
import RxSwift
import RxCocoa

@testable import ReWebKit

class ReWebViewEventTests: XCTestCase {
    var actor: ReWebView?
    var disposeBag: DisposeBag?
    let stubServer = StubServer()
    let defaultURL = "http://localhost:7000/default"
    let failURL = "http://localhost:7000/fail"
    let redirectURL = "http://localhost:7000/redirect"
    
    override func setUp() {
        actor = ReWebView(frame: .zero)
        disposeBag = DisposeBag()
        stubServer.setUp()
    }
    
    override func tearDown() {
        actor = nil
        disposeBag = nil
        stubServer.tearDown()
    }
}

// Single method tests
extension ReWebViewEventTests {
    
    func test_ShouldBeEqualMetaTaginTitleWhenTheReWebViewLoadedAtWebContents() {
        let expectation = XCTestExpectation(description: "event call")
        let expected = "test ReWebview"
        
        actor?.rx.title
            .bind{ title in
                if let title = title {
                    if ( title != "") {
                        XCTAssertEqual(title, expected)
                        expectation.fulfill()
                    }
                }
            }
            .disposed(by: disposeBag!)
        
        actor?.load(defaultURL)
        
         wait(for: [expectation], timeout: 5.0)
    }
    
    func test_ShoudBeEqulEventWhenTheReWebViewLoadingEvent() {
        
        let expectation = XCTestExpectation(description: "event call")
        expectation.expectedFulfillmentCount = 3
        
        let expected = [false, true, false]
        var eventResult: [Bool] = []
        
        actor?.rx.loading
            .bind{ loading in
                eventResult.append(loading)
                expectation.fulfill()
            }
            .disposed(by: disposeBag!)
        
        actor?.load(defaultURL)
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertEqual(eventResult, expected)
    }
    
    func test_ShoudBeEqulEventWhenTheReWebViewEstimatedProgressEvent() {
        let expectation = XCTestExpectation(description: "event call")
        expectation.expectedFulfillmentCount = 4
        
        let expected = [0.0, 0.1, 0.5, 1.0]
        var eventResult: [Double] = []
        
        actor?.rx.estimatedProgress
            .bind{ progress in
                eventResult.append(progress)
                expectation.fulfill()
            }
            .disposed(by: disposeBag!)
        
        actor?.load(defaultURL)
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(eventResult, expected)
    }
    
    func test_ShoudBeEqulExpectedWhenTheReWebViewCurrentURL() {
        
        let expectation = XCTestExpectation(description: "event call")
        expectation.expectedFulfillmentCount = 2
        
        let expected = [nil, defaultURL]
        var eventResult: [String?] = []
        
        actor?.rx.url
            .bind{ url in
                eventResult.append(url?.absoluteString)
                expectation.fulfill()
            }
            .disposed(by: disposeBag!)
        
        actor?.load(defaultURL)
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(eventResult, expected)
    }
    
    func test_ShoudBeEqulExpectedWhenCanGoBacKEvent() {
        let expectation = XCTestExpectation(description: "event call")
        expectation.expectedFulfillmentCount = 2
        
        let expected = [false, true]
        var eventResult: [Bool] = []
        actor?.rx.canGoBack
            .bind{ result in
                eventResult.append(result)
                expectation.fulfill()
            }
            .disposed(by: disposeBag!)
        
        actor?.rx.didFinish
            .bind{ _, _ in
                self.actor?.load(self.failURL)
            }
            .disposed(by: disposeBag!)
        
        actor?.load(defaultURL)
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(eventResult, expected)
    }
    
    func test_ShoudBeEqulExpectedWhenCanGoForwardEvent() {
        let expectation = XCTestExpectation(description: "event call")
        expectation.expectedFulfillmentCount = 2
        
        let expected = [false, true]
        var eventResult: [Bool] = []
        var moveCount = 0
        
        actor?.rx.canGoFoward
            .bind{ result in
                eventResult.append(result)
                expectation.fulfill()
            }
            .disposed(by: disposeBag!)
        
        
        actor?.rx.didFinish
            .bind{ _, _ in
                switch moveCount {
                case 0:
                    self.actor?.load(self.failURL)
                    moveCount = 1
                    break
                case 1:
                    self.actor?.load(self.redirectURL)
                    moveCount = 2
                    break
                default:
                    self.actor?.goBack()
                    break
                }
            }
            .disposed(by: disposeBag!)
        
         actor?.load(defaultURL)
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(eventResult, expected)
        
    }
}
