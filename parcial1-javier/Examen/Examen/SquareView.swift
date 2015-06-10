//
//  TrajectoryView.swift
//  Angry Birds
//
//  Created by Javier De La Rubia on 15/3/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit
import Darwin

@IBDesignable class SquareView: UIView {
    
    var dataSource: SquareViewDataSource!
    
    @IBInspectable
    var stroke: UIColor = UIColor.redColor()
    
    @IBInspectable
    var fill: UIColor = UIColor.redColor()
    
    @IBInspectable
    var background: UIColor = UIColor.redColor()
    
    @IBInspectable
    var side: Double = 50;
    
    @IBInspectable
    var width: Double = 3;
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        if(dataSource == nil) {
            return;
        }
        background.setFill();
        UIRectFill(rect);
        dataSource.setSide(side);
        
        let ctx = UIGraphicsGetCurrentContext();
        
        let path = UIBezierPath()
        
        let values : SquareValues = dataSource.corners();
        
        path.moveToPoint(CGPointMake(CGFloat(values.corners[3].positionX), CGFloat(values.corners[3].positionY)));
        
        for corner in values.corners {
            path.addLineToPoint(CGPointMake(CGFloat(corner.positionX), CGFloat(corner.positionY)));
        }
        
        path.addLineToPoint(CGPointMake(CGFloat(values.corners[0].positionX), CGFloat(values.corners[0].positionY)));
        
        stroke.setStroke();
        fill.setFill();
        path.lineWidth = CGFloat(width);
        path.fill();
        path.stroke();
        
    }
    
    
}
