import Foundation

protocol SectionDetailsAssemblyProtocol {
    func assembly(section: VPSection) -> SectionDetailsDisplayLogic
}

final class SectionDetailsAssembly {}

// MARK: - SectionDetailsAssemblyProtocol

extension SectionDetailsAssembly: SectionDetailsAssemblyProtocol {
    func assembly(section: VPSection) -> SectionDetailsDisplayLogic {
        let networkLayer = NetworkLayer()
        let api = MainApiService(networkLayer: networkLayer)
        let storage = StorageManager()
        let service = MainService(api: api, storage: storage)
        let viewModel = SectionDetailsViewModel(section: section, service: service)
        let viewController = SectionDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
