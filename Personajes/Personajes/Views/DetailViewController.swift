//
//  DetailViewController.swift
//  Personajes
//
//  Created by Alejandro Cantos on 09/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var lastRequestCompleted = false
    var pages: [Page]?
    var character: Character?
    var characterSpecie: Other?
    var vehicles:[Other]?
    var films:[Other]?
    var starShips: [Other]?
    
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var world: UIButton!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var specie: UILabel!
    @IBOutlet weak var skin: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var hair: UILabel!
    @IBOutlet weak var eyes: UILabel!
    @IBOutlet weak var vehicleStack: UIStackView!
    @IBOutlet weak var starShipStack: UIStackView!
    @IBOutlet weak var filmStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav.title = character?.name
        birth.text = character?.birth
        skin.text = character?.skin
        gender.text = character?.gender
        height.text = character?.height
        weight.text = character?.weight
        hair.text = character?.hair
        eyes.text = character?.eyes
        world.setTitle("Cargando...", for: .normal)
        specie.text = "Cargando..."
        updateCharacterData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toWorld"{
            
            let worldDetailView = segue.destination as! WorldDetailController
            
            worldDetailView.lastRequestCompleted = lastRequestCompleted
            worldDetailView.pages = pages!
            worldDetailView.world = character?.homeworld
            worldDetailView.characterParent = character
        }else if segue.identifier == "toMaster"{
            
            let masterView = segue.destination as! ViewController
            masterView.pages = pages!
        }
        
    }
    
    func updateCharacterData(){
        let connection = MoyaConnection()

        connection.UpdateHomeWorld(character: character!){ error in
            if error != nil{
                self.world.setTitle(error?.localizedDescription, for: .normal)
            }else{
                self.world.setTitle(self.character?.homeworld?.name, for: .normal)
            }
        }
        connection.updateSpecie(character: character!){ error in
            if error != nil{
                self.specie.text = error?.localizedDescription
            }else{
                self.specie.text = self.character?.specie?.name
            }
            
        }
        connection.updateVehicles(character: character!){ error in
            
            for vehicle in self.character!.vehicles!{
                let label = UILabel()
                
                if error != nil{
                    label.text = error?.localizedDescription
                }else{
                    label.text = vehicle.name
                }
                label.textAlignment = .center
                self.vehicleStack.addArrangedSubview(label)
            }
        }
        connection.updateShips(character: character!){ error in
            for starship in self.character!.starships!{
                let label = UILabel()
                
                if error != nil{
                    label.text = error?.localizedDescription
                }else{
                    label.text = starship.name
                }
                label.textAlignment = .center
                self.starShipStack.addArrangedSubview(label)
            }
        }
        connection.updateFilms(character: character!){ error in
            
            for film in self.character!.films!{
                let label = UILabel()
                
                if error != nil{
                    label.text = error?.localizedDescription
                }else{
                    label.text = film.title
                }
                label.textAlignment = .center
                self.filmStack.addArrangedSubview(label)
            }
        }
        
        
    }
}
