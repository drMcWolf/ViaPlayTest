import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func unbind() {
        listener = nil
    }
    
    func bind(listner: @escaping Listener) {
        self.listener = listner
        self.listener?(value)
    }
}

