import UIKit

final class SectionDetailsView: UIView {
    private struct Constants {
        static let leadingSpacing: CGFloat = 20
        static let trailingSpacing: CGFloat = 20
    }
    
    // MARK: - Subviews

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
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

private extension SectionDetailsView {
    func commonInit() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        addSubview(descriptionLabel)
    }

    func makeConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingSpacing).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingSpacing).isActive = true
    }
}

// MARK: - Configurable

extension SectionDetailsView: Configurable {
    struct ViewModel {
        let title: String
        let description: String
    }
    
    func configure(with viewModel: ViewModel) {
        descriptionLabel.text = viewModel.description
    }
}
