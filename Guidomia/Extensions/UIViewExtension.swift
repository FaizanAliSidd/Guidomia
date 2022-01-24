//
//  UIView.swift
//  Guidomia
//
//  Created by Faizan Ali on 20/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Used to get frame of view from superview point of view for dropdown
    /// - Parameter subview: subview from which frame needs to be resolved
    /// - Returns: converted frame
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }
        
        var frame = subview.frame

        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)

                superview = superview!.superview
        }
        
        return superview!.convert(frame, to: self)
    }
    
    /// This will add shadow to the view
    /// - Parameters:
    ///   - opacity: opacity of the shadow
    ///   - color: color of the shadow
    ///   - offset: offset of the shadow
    ///   - radius: radius of the shadow
    func addShadow(opacity: Float, color: UIColor, offset: CGSize, radius: CGFloat) {
        
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    /// Add borders to dropdown view
    ///
    /// - Parameters:
    ///   - borderWidth: width of the border
    ///   - borderColor: color of the border
    func addBorders(borderWidth: CGFloat = 0.2, borderColor: CGColor = UIColor.lightGray.cgColor){
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    /// Add shadow to dropdown view
    /// - Parameters:
    ///   - shadowRadius: radius of the shadow
    ///   - alphaComponent: alpha value of the shadow
    func addShadowToView(shadowRadius: CGFloat = 2, alphaComponent: CGFloat = 0.6) {
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: alphaComponent).cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1
    }
    
}
