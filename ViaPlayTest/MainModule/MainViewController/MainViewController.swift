import UIKit

protocol MainDisplayLogic: UIViewController {
    func display(viewModel: SectionsListView.ViewModel)
    func display(error: ErrorView.ViewModel)
}

final class MainViewController: UIViewController {
    // MARK: - Private Properties

    private let viewModel: MainBusinessLogic
    
    // MARK: - Subview Properties

    private lazy var contentView = SectionsListContentView()

    // MARK: - UIViewController

    init(viewModel: MainBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        obtainInitialState()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    func obtainInitialState() {
        contentView.showLoading()
        viewModel.obtain(request: .init())
    }
    
    func addObservers() {
        viewModel.childViewModel.bind { [weak self] contentViewModel in
            self?.display(viewModel: contentViewModel)
        }
        
        viewModel.error.bind { [weak self] errorViewModel in
            if let errorViewModel = errorViewModel {
                self?.display(error: errorViewModel)
            }
        }
        
        contentView.selectedInndex.bind { [weak self] index in
            if let index = index {
                self?.viewModel.select(section: index)
            }
        }
        
        contentView.actionHandler = { [weak self] in
            self?.obtainInitialState()
        }
    }
}

// MARK: - MainDisplayLogic

extension MainViewController: MainDisplayLogic {
    func display(viewModel: SectionsListView.ViewModel) {
        title = viewModel.title
        contentView.showContent(viewModel: viewModel)
    }
    
    func display(error: ErrorView.ViewModel) {
        title = error.title
        contentView.showError(viewModel: error)
    }
}
