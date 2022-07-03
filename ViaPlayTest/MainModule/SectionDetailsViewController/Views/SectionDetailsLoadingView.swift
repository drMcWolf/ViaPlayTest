//
//  SectionDetailsLoadingView.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import UIKit

class SectionDetailsLoadingView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
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
        loadingView.layer.cornerRadius = 5
        return loadingView
    }()
    
    private lazy var descriptionLoadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.layer.cornerRadius = 5
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

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLoadingView.translatesAutoresizingMaskIntoConstraints = false
        titleLoadingView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLoadingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLoadingView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLoadingView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionLoadingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
