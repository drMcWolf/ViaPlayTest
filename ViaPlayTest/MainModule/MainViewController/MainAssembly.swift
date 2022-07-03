 
protocol MainAssemblyProtocol {
    func assemble(output: MainModuleOutput) -> MainDisplayLogic
}


final class MainAssembly: MainAssemblyProtocol {
    
    func assemble(output: MainModuleOutput) -> MainDisplayLogic {
        let networkLayer = NetworkLayer()
        let api = MainApiService(networkLayer: networkLayer)
        let storage = StorageManager()
        let service = MainService(api: api, storage: storage)
        let viewModel = MainViewModel(service: service, output: output)
        let viewController = MainViewController(viewModel: viewModel)
        
        return viewController
    }
}
