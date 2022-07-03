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
    private let service: MainServiceProtocol
    private var models: [VPSection] = []
    private let output: MainModuleOutput
    
    let childViewModel: Observable<SectionsListView.ViewModel> = .init(SectionsListView.ViewModel(title: "Loading...", cellViewModels: []))
    let error: Observable<ErrorView.ViewModel?> = .init(nil)
    
    init(service: MainServiceProtocol,  output: MainModuleOutput) {
        self.service = service
        self.output = output
    }
}

extension MainViewModel: MainBusinessLogic {
    func obtain(request: Main.Obtain.Request) {
        service.obtain { [weak self] result in
            switch result {
            case let .success(models):
                self?.models = models
                let cellViewModels = models.map { UITableViewCell.ViewModel(title: $0.title ?? "Unknown Section") }
                self?.childViewModel.value = .init(title: "Sections list", cellViewModels: cellViewModels)
            case let .failure(error):
                self?.error.value = .init(title: "Error", message: error.localizedDescription, actionTitle: "Try again")
            }
        }
    }
    
    func select(section at: Int) {
        let section = models[at]
        output.handle(output: .onSectionDetails(section))
    }
}
