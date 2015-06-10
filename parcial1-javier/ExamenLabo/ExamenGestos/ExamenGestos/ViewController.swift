//
//  ViewController.swift
//  ExamenGestos
//
//  Created by Javier De La Rubia on 16/4/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import UIKit

class ViewController: UIViewController , CircleViewDataSource{

    @IBOutlet var circleView: CircleView!
    
    var circleModel : CircleModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleModel = CircleModel();
        
        circleView.dataSource = self;
        circleView.setNeedsDisplay();
        
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "processPinch:");
   
        circleView.addGestureRecognizer(pinchRecognizer);
    

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    func processPinch(sender : UIPinchGestureRecognizer) {
        if(sender.state != .Began) {
            circleModel.scale *= Double(sender.scale);
            sender.scale = 1;
            //            trajectoryView.distanceToTarget = Double(sender.value);
            circleView.setNeedsDisplay();
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
    
        circleView.setNeedsDisplay();
        //super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getValues() -> CircleValues {
        
        return circleModel.getValues();
        
    }
    
    func setRadius(radius: Double) {
        circleModel.radius = radius;
    }


}

