//
//  Cells.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    static let identifier: String = "workout-cell"
    
    let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let label: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 20, weight: .light)
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeLayout() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
    
    func configure(model: Workout) {
        setupLayout()
        imageView.loadImage(from: model.image)
        label.text = model.name
    }
}

extension WorkoutCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        setupImageViewConstraint()
        setupLabelConstraint()
    }
}

extension WorkoutCell {
    func setupImageViewConstraint() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    func setupLabelConstraint() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  10)
        ])
    }
}
