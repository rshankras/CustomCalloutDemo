//
//  CustomAnnotationView.swift
//  CustomCalloutDemo
//
//  Created by Ravi Shankar on 24/07/16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, withEvent: event)
        if hitView != nil {
            self.superview?.bringSubviewToFront(hitView!)
        }
        return hitView
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside = CGRectContainsPoint(rect, point )
        if !isInside {
            
            for view in self.subviews {
                isInside = CGRectContainsPoint(view.frame, point)
                if isInside {
                    break
                }
            }
        }
        
        return isInside
    }


    @IBAction func buttonTapped(sender: AnyObject) {
        print("Button Tapped")
    }
}
