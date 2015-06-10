//
//  PokedexModel.swift
//  Pokedex
//
//  Created by Santiago Pavón on 26/11/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import Foundation

/**
* Modelo de datos de los pokemons.
* Tiene informacion sobre las razas y los tipos de pokemons.
*/
class PokedexModel {
    
    // Array de objetos Race.
    var races: [Race]
    
    // Array de objetos Type.
    var types: [Type]
    
    init() {
        
        // Cargar los datos desde pokemons.plist
        // y rellenar las propiedades races y types.
        
        let path = NSBundle.mainBundle().pathForResource("pokemons", ofType: "plist")!
        
        let plist = NSDictionary(contentsOfFile: path)!
        
        let allNames = plist["nombres"]! as! [String:String]
        let allIcons = plist["iconos"]!  as! [String:String]
        let allTypes = plist["tipos"]!   as! [String:[Int]]
        
        // Calcular valor de la propiedad self.races.
        races = []
        for (code,name) in allNames {
            races.append(Race(code: code, name: name, icon: allIcons[code]!))
        }
        races.sort({ (race1:Race, race2:Race) -> Bool in
            return race1.name < race2.name
        })
        
        // Calcular valor de la propiedad self.types.
        types = []
        for (name,raceCodes) in allTypes {
            var racesOfThisType: [Race] = raceCodes.map({ (code) -> Race in
                for race in self.races {
                    if race.code == "\(code)" {
                        return race
                    }
                }
                return Race(code: "\(code)", name: "????", icon: "")
            })
            racesOfThisType.sort({ (race1:Race, race2:Race) -> Bool in
                return race1.name < race2.name
            })
            types.append(Type(name: name, races: racesOfThisType))
        }

        types.sort({ (type1, type2) -> Bool in
            return type1.name < type2.name
        })
    
    }
}




