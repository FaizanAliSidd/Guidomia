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
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }
        
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        
        return superview!.convert(frame, to: self)
    }
    
    /// This will add shadow to the view
    func addShadow(opacity: Float, color: UIColor, offset: CGSize, radius: CGFloat) {
        
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
}
