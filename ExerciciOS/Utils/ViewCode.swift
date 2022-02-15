//
//  ViewCode.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

protocol ViewCode: UIView {
    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
    }
}
