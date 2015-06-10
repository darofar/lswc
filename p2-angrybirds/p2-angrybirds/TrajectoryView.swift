//
//  TrayectoryView.swift
//  p2-angrybirds
//
//  Created by Danny Fonseca on 1/5/15.
//  Copyright (c) 2015 LSWC 2015. All rights reserved.
//
import UIKit

class TrajectoryView: UIView {
    
    //declarations
    var dataSource: TrajectoryViewDataSource!
    var distanceToTarget: Double = 300.0{ didSet { setNeedsDisplay() } }
    let IMGSIZE = 50.0
    
    @IBInspectable
    var birdImage : UIImage!
    @IBInspectable
    var pigImage : UIImage!
    @IBInspectable
    var backgroundImage : UIImage!
    var lineWidth: Double = 3
    var lineColor: UIColor = UIColor.blueColor()
    
    /**
    * Draw bird with fixed size given by IMGSIZE
    */
    private func drawBird(){
        let y = CGFloat(viewHeight(IMGSIZE))
        let rect = CGRectMake(5, y,CGFloat(IMGSIZE), CGFloat(IMGSIZE))
        birdImage.drawInRect(rect)
    }
    
    /**
    * Draw pig with fixed size given by IMGSIZE.
    */
    private func drawPig(){
        let x = CGFloat(distanceToTarget)
        let y = CGFloat(viewHeight(IMGSIZE))
        let rect = CGRectMake(x, y,CGFloat(IMGSIZE), CGFloat(IMGSIZE))
        pigImage.drawInRect(rect)
    }
    
    /**
    * Draw background image
    */
    private func drawBackground(){
        let x = CGFloat(0)
        let y = CGFloat(0)
        let rect = CGRectMake(x, y, self.bounds.size.width, self.bounds.size.height)
        backgroundImage.drawInRect(rect)
    }
    
    /**
    * Check if the trayectory hit the target.
    * - If is a hit change color to red
    * - If is a miss change the color to blue.
    */
    private func checkHit(){
        let endTime = dataSource.endTime()
        var finalPos = dataSource.positionAt(endTime)
        
        if((finalPos.x >= distanceToTarget ) &&
            ( finalPos.x <= (distanceToTarget + IMGSIZE)) ) {
                lineColor = UIColor.greenColor()
        } else {
            lineColor = UIColor.blueColor()
        }
    }
    
    /**
    * Redraw the frame in custom way.
    */
    override func drawRect(rect: CGRect) {
        
        if(dataSource == nil) {
            return;
        }
        
        //self.sendSubviewToBack(backgroundImage)
        drawBackground()
        drawBird()
        drawPig()
        
        //posisionning the path
        let path = UIBezierPath()
        let startTime = dataSource.startTime()
        let endTime = dataSource.endTime()
        var point = dataSource.positionAt(startTime)
        path.moveToPoint(CGPointMake(CGFloat(point.x), CGFloat(viewHeight(point.y))))
        //advance time an draw point by point
        for var t=startTime ; t < endTime ; t += 0.1 {
            point = dataSource.positionAt(t)
            path.addLineToPoint(CGPointMake(CGFloat(point.x),CGFloat(viewHeight(point.y))))
        }
        
        //give line color and stroke
        path.lineWidth = CGFloat(lineWidth)
        lineColor.setStroke()
        path.stroke()
        //now check hit so maybe we should change color.
        checkHit()
    }
    
    //Convert the y-axis
    private func viewHeight(y: Double) -> Double{
        return Double(self.bounds.size.height) - y
    }
    
    func newDistanceToTarget(distancePercentage: Double) {
        distanceToTarget = (distancePercentage)  * ( Double(self.bounds.size.width) - 2*IMGSIZE - 15) + IMGSIZE + 10
    }
}
