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
    
    public var estimateProgress: Observable<Double> {
        return self.observeWeakly(Double.self, "estimateProgress")
            .map{ $0 ?? 0.0 }
    }
    
    public var url: Observable<URL?> {
        return self.observeWeakly(URL.self, "URL")
    }
    
    public var canGoBack: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoBack")
            .map{ $0 ?? false }
    }
    
    public var canGoFoward: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoFoward")
            .map{ $0 ?? false }
    }
}
