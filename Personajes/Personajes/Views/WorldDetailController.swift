//
//  WorldDetailController.swift
//  Personajes
//
//  Created by Alejandro Cantos on 11/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import UIKit

class WorldDetailController: UIViewController {
    
    var lastRequestCompleted = false
    var pages: [Page]?
    var characterParent: Character?
    var world: World?
    

    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var orbital: UILabel!
    @IBOutlet weak var rotation: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var gravity: UILabel!
    @IBOutlet weak var terrain: UILabel!
    @IBOutlet weak var water: UILabel!
    @IBOutlet weak var population: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav.title = world?.name
        orbital.text = world?.orbital_period
        rotation.text = world?.rotation_period
        climate.text = world?.climate
        diameter.text = world?.diameter
        gravity.text = world?.gravity
        terrain.text = world?.terrain
        water.text = world?.surface_water
        population.text = world?.population
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "backToDetail"{
            
            let detailView = segue.destination as! DetailViewController
            detailView.pages = pages!
            detailView.character = characterParent
        }
        
    }
  

}
