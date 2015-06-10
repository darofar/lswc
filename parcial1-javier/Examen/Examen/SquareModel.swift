//
//  TrajectoryModel.swift
//  Angry Birds
//
//  Created by Javier De La Rubia on 15/3/15.
//  Copyright (c) 2015 Javier De La Rubia. All rights reserved.
//

import Foundation
import Darwin

class Position {
    var positionX = 0.0;
    var positionY = 0.0;
    
    init(positionX : Double, positionY: Double) {
        self.positionX = positionX;
        self.positionY = positionY;
    }
}
    

struct SquareValues {
    var corners = [Position]();
}

protocol SquareViewDataSource{
    func corners() -> SquareValues;
    func setSide(side : Double);
}

class SquareModel {
    
    var rotation = 0.0;
    var scale = 1.0;
    var positionX : Double = 0.0;
    var positionY : Double = 0.0;
    var side : Double = 50;
    
    func calculateCorners() -> [Position] {
        var corners : [Position] =  [Position(positionX: scale*side/2, positionY: scale*side/2), Position(positionX: -side/2*scale, positionY: side/2*scale), Position(positionX: -scale*side/2, positionY: -side/2*scale), Position(positionX: side/2*scale, positionY: -side/2*scale)];
        
        rotateCorners(corners);
        translateCorners(corners);
        
        return corners;
        
    }
    
    func rotateCorners(positions : [Position]){
        for pos in positions {
            var tx = pos.positionX;
            var ty = pos.positionY;
           pos.positionX = tx * cos(rotation) - ty * sin(rotation);
           pos.positionY = tx * sin(rotation) + ty * cos(rotation);
        }
    }
    
    func translateCorners(positions : [Position]) {
        for index in indices(positions) {
            positions[index].positionX += positionX;
            positions[index].positionY += positionY;
        }
    }
    
    
    
    
}
