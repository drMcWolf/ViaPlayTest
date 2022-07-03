//
//  SectionDetailsView.swift
//  ViaPlayTest
//
//  Created by Ivan Makarov on 03.07.2022.
//

import UIKit

final class SectionDetailsView: UIView {
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

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(descriptionLabel)
    }

    private func makeConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
    }
}

extension SectionDetailsView: Configurable {
    struct ViewModel {
        let title: String
        let description: String
    }
    
    func configure(with viewModel: ViewModel) {
        descriptionLabel.text = viewModel.description
    }
}
