//
//  ViewController.swift
//  Examen
//
//  Created by Javier De La Rubia on 15/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SquareViewDataSource {
    
    var squareModel : SquareModel!

    @IBOutlet var squareView: SquareView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareModel = SquareModel();
        
        squareView.dataSource = self;
        squareView.setNeedsDisplay();
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "processPan:" );
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "processPinch:");
        
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: "processRotation:");
        
        squareView.addGestureRecognizer(rotateRecognizer);
        
        squareView.addGestureRecognizer(pinchRecognizer);
        
        squareView.addGestureRecognizer(panRecognizer);

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func processRotation(sender : UIRotationGestureRecognizer) {
        if(sender.state != .Began) {
            squareModel.rotation += Double(sender.rotation);
            //            trajectoryView.distanceToTarget = Double(sender.value);
            squareView.setNeedsDisplay();
            sender.rotation = 0;
        }
        
    }
    
    func processPinch(sender : UIPinchGestureRecognizer) {
        if(sender.state != .Began) {
            squareModel.scale *= Double(sender.scale);
            sender.scale = 1;
            //            trajectoryView.distanceToTarget = Double(sender.value);
            squareView.setNeedsDisplay();
        }
    }
    
    func processPan(sender : UIPanGestureRecognizer) {
        
        
        
        let pos = sender.locationInView(sender.view);
        
        if(sender.state != .Began) {
            squareModel.positionX = Double(pos.x);
            squareModel.positionY = Double(pos.y);
            //trajectoryModel.angle -= Double(pos.y-lastPos.y)/100;
            //trajectoryModel.speed += Double(pos.x-lastPos.x);
            //            trajectoryView.distanceToTarget = Double(sender.value);
            squareView.setNeedsDisplay()
            
        }
        sender.setTranslation(CGPointZero, inView: sender.view);
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func corners() -> SquareValues {
        return SquareValues(corners: squareModel.calculateCorners());
    }
    
    func setSide(side : Double) {
        squareModel.side = side;
    }
    
    


}

