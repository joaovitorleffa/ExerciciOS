//
//  UIView+Dashed.swift
//  ExerciciOS
//
//  Created by joaovitor on 15/02/22.
//

import UIKit

extension UIView {
    func addDashedBorder(_ color: UIColor) {
        let color = color.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [20,15]
        shapeLayer.path = UIBezierPath(rect: bounds).cgPath

        self.layer.addSublayer(shapeLayer)
    }
}
