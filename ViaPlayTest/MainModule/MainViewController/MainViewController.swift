import UIKit

protocol MainDisplayLogic: UIViewController {
    func display(viewModel: SectionsListView.ViewModel)
    func display(error: ErrorView.ViewModel)
}

final class MainViewController: UIViewController {
    // MARK: - Public Properties

    // MARK: - Private Properties

    private let viewModel: MainBusinesLogic
    
    // MARK: - Subview Properties

    private lazy var contentView = SectionsListContentView()

    // MARK: - UIViewController

    init(viewModel: MainBusinesLogic) {
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

    // MARK: - Private Methods

    private func obtainInitialState() {
        contentView.showLoading()
        viewModel.obtain(request: .init())
    }
    
    private func addObservers() {
        viewModel.childViewModel.bind { [weak self] contentViewModel in
            self?.display(viewModel: contentViewModel)
        }
        
        viewModel.error.bind { [weak self] errorViewModel in
            if let errorViewModel = errorViewModel {
                self?.display(error: errorViewModel)
            }
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
