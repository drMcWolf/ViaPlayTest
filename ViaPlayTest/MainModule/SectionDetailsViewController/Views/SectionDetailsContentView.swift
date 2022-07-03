//
//  SectionDetailsContainerView.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import UIKit

protocol SectionDetailsContentViewProtocol {
    func showContent(viewModel: SectionDetailsView.ViewModel)
    func showLoading()
    func showError(viewModel: ErrorView.ViewModel)
}

class SectionDetailsContentView: UIView {
    // MARK: - Subviews
    
    private lazy var contentView = SectionDetailsView()
    private lazy var errorView = ErrorView()
    private lazy var loadingView = SectionDetailsLoadingView()
    
    // MARK: - Public Properties
    
    var actionHandler: (() -> Void)? {
        get {
            errorView.actionHandler
        }
        
        set {
            errorView.actionHandler = newValue
        }
    }
    
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

private extension SectionDetailsContentView {
    func commonInit() {
        addSubviews()
        makeConstraints()
        backgroundColor = .white
    }

    func addSubviews() {
        addSubview(contentView)
        addSubview(errorView)
        addSubview(loadingView)
    }

    func makeConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        errorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func show(view: UIView) {
        contentView.isHidden = view !== contentView
        errorView.isHidden = view !== errorView
        loadingView.isHidden = view !== loadingView
    }
}

// MARK: - SectionDetailsContentViewProtocol

extension SectionDetailsContentView: SectionDetailsContentViewProtocol {
    func showContent(viewModel: SectionDetailsView.ViewModel) {
        contentView.configure(with: viewModel)
        show(view: contentView)
    }
    
    func showLoading() {
        show(view: loadingView)
    }
    
    func showError(viewModel: ErrorView.ViewModel) {
        errorView.configure(with: viewModel)
        show(view: errorView)
    }
}
