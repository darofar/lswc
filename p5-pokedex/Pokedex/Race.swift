//
//  Race.swift
//  Pokedex
//
//  Created by Santiago Pavón on 26/11/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import Foundation

/**
* Clase para representar una raza de pokemon.
*/
class Race {
    
    // Codigo de la raza.
    var code: String
    
    // Nombre de la raza.
    var name: String
    
    // Nombre del fichero con el icono de la raza.
    var icon: String

    /**
    * Inicializador de la clase Race.
    */
    init(code: String, name: String, icon: String) {
        
        self.code = code
        self.name = name
        self.icon = icon
        
    }
    
    
}
