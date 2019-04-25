//
//  CustomCell.swift
//  Personajes
//
//  Created by Alejandro Cantos on 08/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {


    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterBirth: UILabel!
    @IBOutlet weak var characterHeight: UILabel!
    @IBOutlet weak var characterWeight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func updateText(character: Character){
        characterName.text = character.name
        characterBirth.text = character.birth
        characterGender.text = character.gender
        characterHeight.text = character.height
        characterWeight.text = character.weight
    }
    
}
