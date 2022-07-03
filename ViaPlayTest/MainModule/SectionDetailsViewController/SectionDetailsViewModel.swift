import Foundation

protocol SectionDetailsBusinessLogic {
    var childViewModel: Observable<SectionDetailsView.ViewModel> { get }
    var error: Observable<ErrorView.ViewModel?> { get }
    func obtain(request: SectionDetails.Obtain.Request)
}

final class SectionDetailsViewModel {
    private struct Constants {
        static let unknownSectionTitle = "Unknown section"
        static let unknownSectionDescription = "Ooops! Something went wrong."
        static let errorTitle = "Error"
        static let errorActionTitle = "Try again"
        static let loadingTitle = "Loading..."
    }
    // MARK: - Private Properties
    
    private let section: VPSection
    private let service: MainServiceProtocol
    
    // MARK: - Public Properties
    
    let childViewModel: Observable<SectionDetailsView.ViewModel> = .init(SectionDetailsView.ViewModel(title: Constants.loadingTitle, description: ""))
    let error: Observable<ErrorView.ViewModel?> = .init(nil)

    init(section: VPSection, service: MainServiceProtocol) {
        self.section = section
        self.service = service
    }
}

// MARK: - SectionDetailsBusinessLogic

extension SectionDetailsViewModel: SectionDetailsBusinessLogic {
    func obtain(request: SectionDetails.Obtain.Request) {
        service.obtainDetails(section: section) { [weak self] result in
            switch result {
            case .success:
                let title = self?.section.title ?? Constants.unknownSectionTitle
                let description = self?.section.sectionDescription ?? Constants.unknownSectionDescription
                self?.childViewModel.value = .init(title: title, description: description)
            case let .failure(error):
                self?.error.value = .init(title: Constants.errorTitle, message: error.localizedDescription, actionTitle: Constants.errorActionTitle)
            }
        }
    }
}
