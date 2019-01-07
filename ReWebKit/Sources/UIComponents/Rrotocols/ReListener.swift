import Foundation
import RxSwift
import RxCocoa

protocol ReListener {
    var canGoBack: BehaviorRelay<Bool> { get }
    var canGoFoward: BehaviorRelay<Bool> { get }
    
}
