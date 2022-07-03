import Foundation
import UIKit

public protocol MainModuleOutput: AnyObject {
   func handle(output: Main.Output)
}

protocol MainBusinesLogic {
    var childViewModel: Observable<SectionsListView.ViewModel> { get }
    var error: Observable<ErrorView.ViewModel?> { get }
    func obtain(request: Main.Obtain.Request)
}

final class MainViewModel {
    private let service: MainServiceProtocol
    let childViewModel: Observable<SectionsListView.ViewModel> = .init(SectionsListView.ViewModel(title: "Loading...", cellViewModels: []))
    let error: Observable<ErrorView.ViewModel?> = .init(nil)
    
    init(service: MainServiceProtocol) {
        self.service = service
    }
}

extension MainViewModel: MainBusinesLogic {
    func obtain(request: Main.Obtain.Request) {
        service.obtain { [weak self] result in
            switch result {
            case let .success(models):
                let cellViewModels = models.map { UITableViewCell.ViewModel(title: $0.title) }
                self?.childViewModel.value = .init(title: "Sections list", cellViewModels: cellViewModels)
            case let .failure(error):
                self?.error.value = .init(title: "Error", message: error.localizedDescription, actionTitle: "Try again")
            }
        }
    }
}
