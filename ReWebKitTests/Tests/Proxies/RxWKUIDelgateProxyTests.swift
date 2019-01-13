import XCTest

@testable import ReWebKit

class RxWKUIDelgateProxyTests: XCTestCase {
    
    var uiDelegateMock: WKUIDelegateMock?
    var actor: ReWebView?
    
    override func setUp() {
        uiDelegateMock = WKUIDelegateMock()
        actor = ReWebView(frame: .zero)
    }
    
    override func tearDown() {
        uiDelegateMock = nil
        actor = nil
    }
}

// Single method test
extension RxWKUIDelgateProxyTests {
    
    func test_ShouldBeNilIfWKUIDelegateNotSetInMock() {
        let expected = RxWKUIDelegateProxy.currentDelegate(for: actor!)
        XCTAssertNil(expected)
    }
    
    func test_ShouldBeNotNilIfInitMethodCalled() {
        let _ = RxWKUIDelegateProxy.setCurrentDelegate(uiDelegateMock, to: actor!)
        XCTAssertNotNil(actor)
    }
    
    func test_ShouldNotBeNilIfWkUIDelegateSetInMock() {
        let _ = RxWKUIDelegateProxy.setCurrentDelegate(uiDelegateMock, to: actor!)
        XCTAssertNotNil(actor)
    }
}
