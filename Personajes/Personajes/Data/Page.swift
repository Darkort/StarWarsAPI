//
//  People.swift
//  Personajes
//
//  Created by Alejandro Cantos on 10/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import Foundation

struct Page: Decodable{
    var count: Int?
    var next: URL?
    var previous: URL?
    var results: [Character] = []
    
    
}
