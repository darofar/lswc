//
//  CircleView.swift
//  ExamenGestos
//
//  Created by Javier De La Rubia on 16/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit
import Darwin

@IBDesignable class CircleView: UIView {
    
    var dataSource: CircleViewDataSource!
    
    @IBInspectable
    var stroke: UIColor = UIColor.redColor()
    
    @IBInspectable
    var fill: UIColor = UIColor.redColor()
    
    @IBInspectable
    var background: UIImage!;

    
    @IBInspectable
    var radius: Double = 50;
    
    @IBInspectable
    var lineWidth: CGFloat = 3;
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        if(dataSource == nil) {
            return;
        }
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        
        var values : CircleValues = dataSource.getValues();
        
        background.drawAtPoint(rect.origin);
        

        CGContextAddArc(context , rect.midX, rect.midY, CGFloat(values.radius), CGFloat(0), CGFloat(2*M_PI), 1);
        
        CGContextClosePath(context);
    
        CGContextSetLineWidth(context, lineWidth);
        
        CGContextSetStrokeColorWithColor(context,UIColor.magentaColor().CGColor)
        
        CGContextSetFillColorWithColor(context,fill.CGColor);
        
        CGContextDrawPath(context, kCGPathFillStroke)
        
    }
    
    
}
