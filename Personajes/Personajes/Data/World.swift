//
//  World.swift
//  Personajes
//
//  Created by Alejandro Cantos on 10/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import Foundation


class World: Decodable{
    
    var name: String
    var rotation_period: String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents:[String]?
    var films:[String]?
}
