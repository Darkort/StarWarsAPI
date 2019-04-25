//
//  JsonParser.swift
//  Personajes
//
//  Created by Alejandro Cantos on 09/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//
import Foundation
import UIKit

class ApiDecoder{

    static var task: URLSessionDataTask?
    
    static func getPeopleFrom(url: URL, completion: @escaping(Page?, Error?)-> Void){
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var object: Page
            
            if error != nil{
                if (error! as NSError).code != -999{
                    completion(nil,error)
                }
                print(error!)
            }else{
                do{
                    let decoder = JSONDecoder()
                    //usar GUARD
                    object = try decoder.decode(Page.self,from: data!)
                    updatePeopleData(people: object)
                    completion(object,nil)
                }catch{
                    completion(nil,error)
                }
            }
            
        }
        task?.resume()
    }
    
    
    
    static func getPlanetFrom(url: URL, completion: @escaping(World)-> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var object: World
            
            if error != nil{
                print(error!)
            }else{
                do{
                    let decoder = JSONDecoder()
                    object = try decoder.decode(World.self,from: data!)
                    completion(object)
                }catch{
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    static func getOtherFrom(url: URL, completion: @escaping(Other)-> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var object: Other
            
            if error != nil{
                print(error!)
            }else{
                do{
                    let decoder = JSONDecoder()
                    object = try decoder.decode(Other.self,from: data!)
                    completion(object)
                }catch{
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    
    
    
    static func updatePeopleData(people: Page){
        for character in people.results{
            updateCharacterData(character: character)
        }
    }
    
    
    
    
    
    static func updateCharacterData(character: Character){
        //update world
        ApiDecoder.getPlanetFrom(url: character.homeworldUrl){data in
            DispatchQueue.main.async {
                character.homeworld = data
            }
        }
        
        //update specie
        for specieUrl in character.speciesUrl{
            ApiDecoder.getOtherFrom(url: specieUrl){data in
                DispatchQueue.main.async {
                    character.specie = data
                }
            }
        }
        
        
        //update vehicles
        for vehicleUrl in character.vehicleUrls{
            ApiDecoder.getOtherFrom(url: vehicleUrl){data in
                DispatchQueue.main.async {
                    character.film?.append(data)
                }
            }
        }
        //update starships
        for starshipUrl in character.starshipUrls{
            ApiDecoder.getOtherFrom(url: starshipUrl){data in
                DispatchQueue.main.async {
                    character.starships?.append(data)
                }
            }
        }
        //update films
        for filmUrl in character.filmUrls{
            ApiDecoder.getOtherFrom(url: filmUrl){data in
                DispatchQueue.main.async {
                    character.films?.append(data)
                }
            }
        }
        
        
    }
    
}
