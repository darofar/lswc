//
//  CircleModel.swift
//  ExamenGestos
//
//  Created by Javier De La Rubia on 16/4/15.
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


struct CircleValues {
    var center : Position;
    var radius : Double;
}

protocol CircleViewDataSource{
    func getValues() -> CircleValues;
    func setRadius(radius : Double);
}

class CircleModel {
    

    var scale = 1.0;
    var positionX : Double = 0.0;
    var positionY : Double = 0.0;
    var radius : Double = 50;
    
    func getValues() -> CircleValues {
        
        var cirValues : CircleValues = CircleValues(center: Position(positionX: positionX, positionY: positionY), radius: radius*scale);
        
        return cirValues;
        
    }
    
    
    
    
}
