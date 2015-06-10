//
//  ViewController.swift
//  p3-angrybirdsgestures
//
//  Created by Danny Fonseca on 1/5/15.
//  Copyright (c) 2015 LSWC 2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TrajectoryViewDataSource {

    @IBOutlet weak var trajectoryView: TrajectoryView!
    var trajectoryModel : TrajectoryModel!
    var lastPos : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trajectoryModel = TrajectoryModel();
        trajectoryView.dataSource = self;
        trajectoryView.setNeedsDisplay();
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "processPan:" );
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "processPinch:");
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: "processRotation:");
        
        trajectoryView.addGestureRecognizer(rotateRecognizer);
        trajectoryView.addGestureRecognizer(pinchRecognizer);
        trajectoryView.addGestureRecognizer(panRecognizer);

    }
    
    //gestures proccesors. 
    // pan mueve el objetivo, es lo que hacia antes el targetSlider
    func processPan(sender : UIPanGestureRecognizer) {
        let pos = sender.locationInView(sender.view);
        if(sender.state != .Began) {
            trajectoryView.distanceToTarget = Double(pos.x);
            trajectoryView.setNeedsDisplay()
        }
        sender.setTranslation(CGPointZero, inView: sender.view);
        lastPos = pos;
    }
    
    //pinch cambia la velocidad
    func processPinch(sender : UIPinchGestureRecognizer) {
        if(sender.state != .Began) {
            trajectoryModel.speed *= Double(sender.scale);
            sender.scale = 1;
            trajectoryView.setNeedsDisplay();
        }
    }
    
    //rotation cambia el angulo de tiro.
    func processRotation(sender : UIRotationGestureRecognizer) {
        if(sender.state != .Began) {
            trajectoryModel.angle += Double(sender.rotation);
            trajectoryView.setNeedsDisplay();
            sender.rotation = 0;
        }
        
    }
    
    //trajectory protocol implementation.
    func startTime() -> Double {
        return 0.0
    }
    func endTime() -> Double {
        return trajectoryModel.time()
    }
    func positionAt(time: Double) -> Position{
        return Position(x: trajectoryModel.distance(time), y: trajectoryModel.height(time));
    }



}

