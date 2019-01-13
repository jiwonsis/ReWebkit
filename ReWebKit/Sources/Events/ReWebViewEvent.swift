import RxCocoa
import RxSwift

extension Reactive where Base: ReWebView {
    public var title: Observable<String?> {
        return self.observeWeakly(String.self, "title")
    }
    
    public var loading: Observable<Bool> {
        return self.observeWeakly(Bool.self, "loading")
            .map{ $0 ?? false }
    }
    
    public var estimatedProgress: Observable<Double> {
        return self.observeWeakly(Double.self, "estimatedProgress")
            .map{ $0 ?? 0.0 }
    }
    
    public var url: Observable<URL?> {
        return self.observeWeakly(URL.self, "URL")
    }
    
    public var canGoBack: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoBack")
            .map{ $0! }
    }
    
    public var canGoFoward: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoForward")
            .map{ $0! }
    }
}
