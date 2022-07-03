//
//  SectionDetailsViewModel.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import Foundation

protocol SectionDetailsBusinessLogic {
    var childViewModel: Observable<SectionDetailsView.ViewModel> { get }
    var error: Observable<ErrorView.ViewModel?> { get }
    func obtain(request: SectionDetails.Obtain.Request)
}

final class SectionDetailsViewModel {
    private let section: VPSection
    private let service: MainServiceProtocol
    
    let childViewModel: Observable<SectionDetailsView.ViewModel> = .init(SectionDetailsView.ViewModel(title: "Loading...", description: ""))
    let error: Observable<ErrorView.ViewModel?> = .init(nil)

    init(section: VPSection, service: MainServiceProtocol) {
        self.section = section
        self.service = service
    }
}

extension SectionDetailsViewModel: SectionDetailsBusinessLogic {
    func obtain(request: SectionDetails.Obtain.Request) {
        service.obtainDetails(section: section) { [weak self] result in
            switch result {
            case .success:
                let title = self?.section.title ?? "Unknown section"
                let description = self?.section.sectionDescription ?? "Ooops! Something went wrong."
                self?.childViewModel.value = .init(title: title, description: description)
            case let .failure(error):
                self?.error.value = .init(title: "Error", message: error.localizedDescription, actionTitle: "Try again")
            }
        }
    }
}
