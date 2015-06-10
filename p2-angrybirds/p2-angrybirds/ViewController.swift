//
//  ViewController.swift
//  p2-angrybirds
//
//  Created by Danny Fonseca on 1/5/15.
//  Copyright (c) 2015 LSWC 2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TrajectoryViewDataSource {

    //declarations
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var targetSlider: UISlider!
    @IBOutlet weak var trajectoryView: TrajectoryView!
    var trajectoryModel : TrajectoryModel!
    
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
    
    
    @IBAction func changeAngel(sender: UISlider) {
        trajectoryModel.angle = Double(sender.value)
        trajectoryView.setNeedsDisplay()
    }
    
    @IBAction func changeSpeed(sender: UISlider) {
        trajectoryModel.speed = Double(sender.value)
        trajectoryView.setNeedsDisplay()
    }
    
    
    @IBAction func changeTargetDistance(sender: UISlider) {
        trajectoryView.newDistanceToTarget(Double(sender.value))
        trajectoryView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trajectoryModel = TrajectoryModel();
        trajectoryView.dataSource = self;
        trajectoryView.setNeedsDisplay();
        //aquí debería definir la distancia al objetivo en base a el tamaño final de la vista
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

