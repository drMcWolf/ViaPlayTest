import UIKit

public final class MainView: UIView {
    // MARK: - Public Properties

    // MARK: - Subview Properties

    
    // MARK: - Private Properties

    
    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func commonInit() {
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {

    }

    private func makeConstraints() {

    }
}

// MARK: - Configurable

extension MainView: Configurable {
    public struct ViewModel {}
    func configure(with viewModel: ViewModel) {}
}
