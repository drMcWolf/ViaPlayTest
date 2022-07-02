import Foundation

public protocol MainModuleOutput: AnyObject {
   func handle(output: Main.Output)
}

protocol MainBusinesLogic {
    func obtain(request: Main.Obtain.Request)
}

final class MainViewModel {
    private let service: MainServiceProtocol
    
    init(service: MainServiceProtocol) {
        self.service = service
    }
}

extension MainViewModel: MainBusinesLogic {
    func obtain(request: Main.Obtain.Request) {
        service.obtain { result in
            
        }
    }
}
