//
//  WorkoutCellSectionHeader.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

class WorkoutCellSectionHeader: UICollectionReusableView {
    static let identifier: String = "workout-cell-section-header"
    
    var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UILabel())
    
    var descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, description: NSAttributedString) {
        titleLabel.text = title
        descriptionLabel.attributedText = description
    }
}

extension WorkoutCellSectionHeader: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
