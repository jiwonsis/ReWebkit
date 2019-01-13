import XCTest

@testable import ReWebKit

class RxWkNavigationDelegateProxyTests: XCTestCase {
    
    var actor: ReWebView?
    var navigationMock: WKNavigationDelegateMock?
    
    override func setUp() {
        actor = ReWebView(frame: .zero)
        navigationMock = WKNavigationDelegateMock()
    }
    
    override func tearDown() {
        actor = nil
        navigationMock = nil
    }
    
   
}

// Single method test
extension RxWkNavigationDelegateProxyTests {
    
    func test_ShouldBeNilIfWKUIDelegateNotSetInMock() {
        let expected = RXWkNavigationDelegateProxy.currentDelegate(for: actor!)
        XCTAssertNil(expected)
    }
    
    func test_ShouldBeNotNilIfInitMethodCalled() {
        let proxy = RXWkNavigationDelegateProxy(parentObject: actor!)
        XCTAssertNotNil(proxy)
    }
    
    func test_ShouldNotBeNilIfWKUIDelegateSetInMock() {
        let _ = RXWkNavigationDelegateProxy.setCurrentDelegate(navigationMock, to: actor!)
        let expected = RXWkNavigationDelegateProxy.currentDelegate(for: actor!)
        XCTAssertNotNil(expected)
    }
}
