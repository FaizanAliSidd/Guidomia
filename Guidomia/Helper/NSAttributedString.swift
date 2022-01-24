//
//  NSAttributedString.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// Specify line spacing
    /// - Parameter spacing: spacing value
    /// - Returns: attributed string
    private func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
    
    /// Adds orange color bullet string
    /// - Returns: attributed string
    private func withOrangeBullet() -> NSAttributedString {
        
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.orange
        attributes[.font] = UIFont.systemFont(ofSize: 18, weight: .heavy)
        let attributedString = NSAttributedString(string:  Constants.bulletPointAndSpace, attributes: attributes)
        return attributedString
    }
    
    
    /// Method to dsiplay bulleted text in the pros and cons section
    /// - Parameter inputArray: array of string which needs to be processed
    /// - Returns: bulleted text string to be shown
    func displayBulletedText(for inputArray:[String]) -> NSAttributedString {
        
        let bullet = NSAttributedString().withOrangeBullet()
        let prepareString = NSMutableAttributedString()
        inputArray.forEach {
            prepareString.append(bullet)
            prepareString.append(NSAttributedString(string: $0))
            prepareString.append(NSAttributedString(string: Constants.nextLine))
        }
        let combination = NSMutableAttributedString()
        combination.append(prepareString)
        return combination.withLineSpacing(Constants.lineSpaceBetweenBullets)
    }
}
