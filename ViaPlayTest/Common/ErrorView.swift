import UIKit

protocol ErrorViewDelegate: AnyObject {
    func actionButtonPressed()
}

final class ErrorView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
        static let iconName: String = "warning"
    }
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = .init()
    private lazy var imageView: UIImageView = {
        UIImageView(image: UIImage(named: Constants.iconName))
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.spacing
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, actionButton])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: ErrorViewDelegate?
    
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

private extension ErrorView {
    func commonInit() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        addSubview(stackView)
    }
    
    func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc func actionButtonDidTap() {
        delegate?.actionButtonPressed()
    }
}

// MARK: - Configurable

extension ErrorView: Configurable {
    struct ViewModel {
        let title: String
        let message: String
        let actionTitle: String
    }
    
    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.message
        actionButton.setTitle(viewModel.actionTitle, for: .normal)
    }
}
