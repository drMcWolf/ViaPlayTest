import UIKit

class SectionLoadingView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
        static let loadingViewCornerRadius: CGFloat = 5
        static let separatorHeight: CGFloat = 1
        static let titleLoadingViewWidth: CGFloat = 200
    }
    
    // MARK: - Subviews

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLoadingView, separatorView])
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    
    private lazy var titleLoadingView = LoadingView()
    private lazy var separatorView = LoadingView()
    
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

private extension SectionLoadingView {
    func commonInit() {
        addSubviews()
        makeConstraints()
        titleLoadingView.layer.cornerRadius = Constants.loadingViewCornerRadius
    }

    func addSubviews() {
        addSubview(stackView)
    }

    func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleLoadingView.translatesAutoresizingMaskIntoConstraints = false
        titleLoadingView.widthAnchor.constraint(equalToConstant: Constants.titleLoadingViewWidth).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight).isActive = true
        separatorView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
}
