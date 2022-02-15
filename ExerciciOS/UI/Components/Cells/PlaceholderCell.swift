//
//  PlaceholderCell.swift
//  ExerciciOS
//
//  Created by joaovitor on 15/02/22.
//

import UIKit

class PlaceholderCell: UICollectionViewCell {
    static let identifier: String = "placeholder-cell"
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Toque duas vezes em um execício para adicioná-lo ao seu treino"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addDashedBorder(Colors.placeholderBorder)
    }
}

extension PlaceholderCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
