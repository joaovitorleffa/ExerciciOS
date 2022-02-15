//
//  NSAttributedString+Color.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

extension NSAttributedString {
    static func colored(_ text: String, color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func appendColored(_ text: String, color: UIColor) -> NSAttributedString {
        let mutable: NSMutableAttributedString = .init(attributedString: self)
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        mutable.append(attributedString)
        
        return mutable
    }
}
