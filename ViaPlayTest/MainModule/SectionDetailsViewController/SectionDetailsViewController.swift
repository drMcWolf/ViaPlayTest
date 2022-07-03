import UIKit

protocol SectionDetailsDisplayLogic: UIViewController {
    func display(viewModel: SectionDetailsView.ViewModel)
    func display(error: ErrorView.ViewModel)
}

class SectionDetailsViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel: SectionDetailsBusinessLogic
    private lazy var contentView = SectionDetailsContentView()
    
    // MARK: - UIView
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        obtainInitialState()
    }
    
    init(viewModel: SectionDetailsBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Methods

private extension SectionDetailsViewController {
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
        
        contentView.actionHandler = { [weak self] in
            self?.obtainInitialState()
        }
    }
}

// MARK: - SectionDetailsDisplayLogic

extension SectionDetailsViewController: SectionDetailsDisplayLogic {
    func display(viewModel: SectionDetailsView.ViewModel) {
        title = viewModel.title
        contentView.showContent(viewModel: viewModel)
    }
    
    func display(error: ErrorView.ViewModel) {
        title = error.title
        contentView.showError(viewModel: error)
    }
}
