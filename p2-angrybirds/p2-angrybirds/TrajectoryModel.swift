//
//  TrajectoryModel.swift
//  p2-AngryBirds
//
//  Created by Danny Fonseca on 9/4/15.
//  Copyright (c) 2015 LSWC 2015. All rights reserved.
//

import Foundation
import Darwin

struct Position {
    var x = 0.0;
    var y = 0.0;
}

protocol TrajectoryViewDataSource {
    func startTime()                -> Double
    func endTime()                  -> Double
    func positionAt(time: Double)   -> Position
}

class TrajectoryModel {
    
    let GRAVITY = 9.81
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    var shootAngle : Double = M_PI/4;
    
    var speed: Double{
        get{
            return sqrt(speedX * speedX + speedY * speedY);
        }
        set{
            speedX = newValue * cos(shootAngle);
            speedY = newValue * sin(shootAngle);
        }
    }
    
    var angle: Double {
        get{
            return shootAngle;
        }
        set {
            speedX = speed * cos(newValue);
            speedY = speed * sin(newValue);
            shootAngle = newValue;
        }
    }
    
    func time() -> Double{
        return 2*speedY/GRAVITY;
    }
    
    func distance(time: Double) -> Double{
        return speedX * time;
    }
    
    func height(time: Double) -> Double{
        return speedY * time - 0.5 * GRAVITY * time * time;
    }
    
    init() {
        self.speed = 50;
        self.angle = M_PI/4;
    }
    
    init(speed: Double, angle: Double){
        self.speed = speed;
        self.angle = angle;
    }
}
