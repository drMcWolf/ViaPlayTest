import Foundation
import UIKit

public protocol MainModuleOutput: AnyObject {
   func handle(output: Main.Output)
}

protocol MainBusinessLogic {
    var childViewModel: Observable<SectionsListView.ViewModel> { get }
    var error: Observable<ErrorView.ViewModel?> { get }
    func obtain(request: Main.Obtain.Request)
    func select(section at: Int)
}

final class MainViewModel {
    private struct Constants {
        static let unknownSectionTitle = "Unknown section"
        static let contentTitle = "Sections list"
        static let errorTitle = "Error"
        static let errorActionTitle = "Try again"
        static let loadingTitle = "Loading..."
    }
    
    // MARK: - Private Properties
    
    private let service: MainServiceProtocol
    private var models: [VPSection] = []
    private let output: MainModuleOutput
    
    // MARK: - Public Properties
    
    let childViewModel: Observable<SectionsListView.ViewModel> = .init(SectionsListView.ViewModel(title: Constants.loadingTitle, cellViewModels: []))
    let error: Observable<ErrorView.ViewModel?> = .init(nil)
    
    init(service: MainServiceProtocol,  output: MainModuleOutput) {
        self.service = service
        self.output = output
    }
}

// MARK: - MainBusinessLogic

extension MainViewModel: MainBusinessLogic {
    func obtain(request: Main.Obtain.Request) {
        service.obtain { [weak self] result in
            switch result {
            case let .success(models):
                self?.models = models
                let cellViewModels = models.map { UITableViewCell.ViewModel(title: $0.title ?? Constants.unknownSectionTitle) }
                self?.childViewModel.value = .init(title: Constants.contentTitle, cellViewModels: cellViewModels)
            case let .failure(error):
                self?.error.value = .init(title: Constants.errorTitle, message: error.localizedDescription, actionTitle: Constants.errorActionTitle)
            }
        }
    }
    
    func select(section at: Int) {
        let section = models[at]
        output.handle(output: .onSectionDetails(section))
    }
}
