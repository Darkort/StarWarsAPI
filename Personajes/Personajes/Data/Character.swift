//
//  Character.swift
//  Personajes
//
//  Created by Alejandro Cantos on 09/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import Foundation

class Character: Decodable{
    
    var name: String
    var birth: String
    var homeworldUrl: URL
    var speciesUrl: [URL]
    var specie: Other?
    var skin: String
    var gender: String
    var height: String
    var weight: String
    var hair: String
    var eyes: String
    var vehicleUrls: [URL]
    var starshipUrls: [URL]
    var filmUrls: [URL]
    var film: [Other]?
    var starships: [Other]?
    var films: [Other]?
    var homeworld: World?
    var vehicles: [Other]?
    
    
    private enum CodingKeys: String, CodingKey{
        case name
        case birth = "birth_year"
        case homeworldUrl = "homeworld"
        case species
        case skin = "skin_color"
        case gender
        case height
        case weight = "mass"
        case hair = "hair_color"
        case eyes = "eye_color"
        case vehicleUrls = "vehicles"
        case starshipUrls = "starships"
        case filmUrls = "films"
    }
 
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        birth = try values.decode(String.self, forKey: .birth)
        homeworldUrl = try values.decode(URL.self, forKey: .homeworldUrl)
        speciesUrl = try values.decode([URL].self, forKey: .species)
        skin = try values.decode(String.self, forKey: .skin)
        gender = try values.decode(String.self, forKey: .gender)
        height = try values.decode(String.self, forKey: .height)
        weight = try values.decode(String.self, forKey: .weight)
        hair = try values.decode(String.self, forKey: .hair)
        eyes = try values.decode(String.self, forKey: .eyes)
        vehicleUrls = try values.decode([URL].self, forKey: .vehicleUrls)
        starshipUrls = try values.decode([URL].self, forKey: .starshipUrls)
        filmUrls = try values.decode([URL].self, forKey: .filmUrls)
        
        vehicles = []
        film = []
        starships = []
        films = []
    }

    
    
    
}
