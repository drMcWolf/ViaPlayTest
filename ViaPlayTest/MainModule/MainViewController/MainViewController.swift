import UIKit

public protocol MainDisplayLogic: UIViewController {
    func display(viewModel: MainView.ViewModel)
}

final class MainViewController: UIViewController {
    // MARK: - Public Properties

    // MARK: - Private Properties

    private let viewModel: MainBusinesLogic
    
    // MARK: - Subview Properties

    private lazy var contentView = MainView()

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
        obtainInitialState()
    }

    // MARK: - Private Methods

    private func obtainInitialState() {
        viewModel.obtain(request: .init())
    }
}

// MARK: - MainDisplayLogic

extension MainViewController: MainDisplayLogic {
    func display(viewModel: MainView.ViewModel) {}
}
