//
//  Colors.swift
//  ExerciciOS
//
//  Created by joaovitor on 15/02/22.
//

import UIKit

struct Colors {
    static let aerobic: UIColor = UIColor(named: "aerobic")!
    static let bodybuilder: UIColor = UIColor(named: "bodybuilder")!
    static let placeholderBorder: UIColor = UIColor(named: "placeholderBorder")!
    
    static func `for`(_ category: WorkoutCategory) -> UIColor {
        switch category {
        case .aerobic:
            return aerobic
        case .bodybuilding:
            return bodybuilder
        }
    }
}
