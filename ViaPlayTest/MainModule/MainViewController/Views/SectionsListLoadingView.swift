import UIKit

class SectionsListLoadingView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
        static let stackViewHeight: CGFloat = 224
    }
    
    // MARK: - Subviews
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension SectionsListLoadingView {
    func commonInit() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        addSubview(stackView)
        
        for _ in 0...4 {
            stackView.addArrangedSubview(SectionLoadingView())
        }
    }

    func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight).isActive = true
    }
}
