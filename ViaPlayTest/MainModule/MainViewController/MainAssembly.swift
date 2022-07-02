 
public protocol MainAssemblyProtocol {
    func assemble(output: MainModuleOutput) -> MainDisplayLogic
}

/// Assembly собирает модуль, отвечающий за 
final class MainAssembly: MainAssemblyProtocol {
    
    func assemble(output: MainModuleOutput) -> MainDisplayLogic {
        let networkLayer = NetworkLayer()
        let api = MainApiService(networkLayer: networkLayer)
        let service = MainService(api: api)
        let viewModel = MainViewModel(service: service)
        let viewController = MainViewController(viewModel: viewModel)
        
        return viewController
    }
}