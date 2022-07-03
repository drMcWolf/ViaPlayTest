import UIKit

class SectionDetailsLoadingView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
        static let loadingViewCornerRadius: CGFloat = 5
        static let titleLoadinViewSize: CGSize = .init(width: 150, height: 50)
        static let descriptionLoadingView: CGSize = .init(width: 200, height: 50)
    }
    
    // MARK: - Subviews
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLoadingView, descriptionLoadingView])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = Constants.spacing
        return stackView
    }()

    private lazy var titleLoadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.layer.cornerRadius = Constants.loadingViewCornerRadius
        return loadingView
    }()
    
    private lazy var descriptionLoadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.layer.cornerRadius = Constants.loadingViewCornerRadius
        return loadingView
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

private extension SectionDetailsLoadingView {
    func commonInit() {
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        addSubview(stackView)
    }

    func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLoadingView.translatesAutoresizingMaskIntoConstraints = false
        titleLoadingView.widthAnchor.constraint(equalToConstant: Constants.titleLoadinViewSize.width).isActive = true
        titleLoadingView.heightAnchor.constraint(equalToConstant: Constants.titleLoadinViewSize.height).isActive = true
        
        descriptionLoadingView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLoadingView.widthAnchor.constraint(equalToConstant: Constants.descriptionLoadingView.width).isActive = true
        descriptionLoadingView.heightAnchor.constraint(equalToConstant: Constants.descriptionLoadingView.height).isActive = true
    }
}
