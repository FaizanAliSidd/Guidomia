//
//  NavBarExtension.swift
//  Guidomia
//
//  Created by Faizan Ali on 20/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 252/255, green: 96/255, blue: 22/255, alpha: 1)
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
    
    func setLeftTitle(label text: String) {
        self.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 44))
        titleLabel.font = UIFont(name: Constants.navigationFont, size: 30)
        titleLabel.text = text
        titleLabel.textColor = .white
        self.navigationBar.addSubview(titleLabel)
    }
}
