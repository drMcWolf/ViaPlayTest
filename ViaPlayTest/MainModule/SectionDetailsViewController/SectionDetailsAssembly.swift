//
//  SectionDetailsAssembly.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import Foundation

protocol SectionDetailsAssemblyProtocol {
    func assembly(section: VPSection) -> SectionDetailsDisplayLogic
}

final class SectionDetailsAssembly {
    
}

extension SectionDetailsAssembly: SectionDetailsAssemblyProtocol {
    func assembly(section: VPSection) -> SectionDetailsDisplayLogic {
        let networkLayer = NetworkLayer()
        let api = MainApiService(networkLayer: networkLayer)
        let service = MainService(api: api)
        let viewModel = SectionDetailsViewModel(section: section, service: service)
        let viewController = SectionDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
