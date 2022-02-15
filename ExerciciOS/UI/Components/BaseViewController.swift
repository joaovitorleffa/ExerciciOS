//
//  BaseViewController.swift
//  ExerciciOS
//
//  Created by joaovitor on 14/02/22.
//

import UIKit

class BaseViewController<View>: UIViewController where View: ViewCode {
    var customView: View = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // quando criamos um init devemos usar esse required init também
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}
