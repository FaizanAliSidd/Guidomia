//
//  NSAttributedString.swift
//  Guidomia
//
//  Created by William Scott on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    private func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
    
    private func withOrangeBullet() -> NSAttributedString {
        
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.orange
        attributes[.font] = UIFont.systemFont(ofSize: 18, weight: .heavy)
        let attributedString = NSAttributedString(string:  Constants.bulletPointAndSpace, attributes: attributes)
        return attributedString
    }
    
    
    func displayBulletedText(for inputArray:[String]) -> NSAttributedString {
        
        let bullet = NSAttributedString().withOrangeBullet()
        let eas = NSMutableAttributedString()
        inputArray.forEach {
            eas.append(bullet)
            eas.append(NSAttributedString(string: $0))
            eas.append(NSAttributedString(string: Constants.nextLine))
        }
        
        let combination = NSMutableAttributedString()
        combination.append(eas)
        return combination.withLineSpacing(Constants.lineSpaceBetweenBullets)
    }
}
