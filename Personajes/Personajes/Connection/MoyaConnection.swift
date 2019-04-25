//
//  MoyaManager.swift
//  Personajes
//
//  Created by Alejandro Cantos on 23/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import Foundation
import Moya

struct MoyaConnection{
    
    let provider = MoyaProvider<MoyaTarget>()
    public var request: Cancellable?
    
    
    mutating func getPage(page: Int ,completion: @escaping(Page?,Error?)-> Void){
        request = provider.request(.getPage(page: page)){ result in
            switch result {
            case let .success(moyaResponse):
                do{
                    let page = try moyaResponse.map(Page.self)
                    completion(page,nil)
                }catch{
                    print(error.localizedDescription)
                    completion(nil,error)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
    }
    
  
    
    func UpdateHomeWorld(character: Character, completion: @escaping(Error?)->Void){
        let worldUrl = character.homeworldUrl
        provider.request(.getFrom(baseURL: worldUrl)){ result in
            switch result{
                case .success(let response):
                    do{
                        character.homeworld = try response.map(World.self)
                        completion(nil)
                    }catch{
                        print(error.localizedDescription)
                        completion(error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(error)
            }
        }
    }
    
    func updateSpecie(character: Character, completion: @escaping(Error?)->Void){
        for specieURL in character.speciesUrl{
            getOtherFrom(url: specieURL){ data, error in
                if error != nil{
                    print(error!.localizedDescription)
                    completion(error)
                }else{
                    character.specie = data
                    completion(nil)
                }
            }
        }
    }
    
    func updateVehicles(character: Character, completion: @escaping(Error?)->Void){
        for vehicleURL in character.vehicleUrls{
            getOtherFrom(url: vehicleURL){ data, error in
                if error != nil{
                    print(error!.localizedDescription)
                    completion(error)
                }else{
                    character.vehicles?.removeAll()
                    character.vehicles?.append(data!)
                    completion(nil)
                }
            }
        }
    }
    
    func updateShips(character: Character, completion: @escaping(Error?)->Void){
        for shipURL in character.starshipUrls{
            getOtherFrom(url: shipURL){ data, error in
                if error != nil{
                    print(error!.localizedDescription)
                    completion(error)
                }else{
                    character.starships?.removeAll()
                    character.starships?.append(data!)
                    completion(nil)
                }
            }
        }
    }
    
    func updateFilms(character: Character, completion: @escaping(Error?)->Void){
        for filmURL in character.filmUrls{
            getOtherFrom(url: filmURL){ data, error in
                if error != nil{
                    print(error!.localizedDescription)
                    completion(error)
                }else{
                    character.films?.removeAll()
                    character.films?.append(data!)
                    completion(nil)
                }
            }
        }
    }
  
    
    
    func getOtherFrom(url: URL, completion: @escaping(Other?,Error?)-> Void){
        provider.request(.getFrom(baseURL: url)){ result in
            switch result{
            case .success(let response):
                do{
                    let other = try response.map(Other.self)
                    completion(other,nil)
                }catch{
                    print(error.localizedDescription)
                    completion(nil,error)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
    }
    

}
