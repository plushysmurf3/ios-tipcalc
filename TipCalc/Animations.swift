//
//  Animations.swift
//  TipCalc
//
//  Created by Savio Tsui on 9/28/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import Foundation
import UIKit

class Animations
{
    private var screenSize: CGRect = UIScreen.main.bounds
    
    func appear(_ view: UIView, _ duration: Double, _ offset: CGFloat) {
        
        view.alpha = 0
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height + view.frame.height)
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
            view.center = CGPoint(x: self.screenSize.width / 2, y: view.frame.height / 2 + offset)
        })
    }
    
    func disappear(_ view: UIView, _ duration: Double) {
        view.alpha = 1
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height + view.frame.height)
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
            view.center = CGPoint(x: self.screenSize.width / 2, y: self.screenSize.height + view.frame.height)
            
        })
    }
}
