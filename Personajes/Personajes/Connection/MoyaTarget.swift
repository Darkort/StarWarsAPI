//
//  MoyaManager.swift
//  Personajes
//
//  Created by Alejandro Cantos on 22/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import Foundation
import Moya

public enum MoyaTarget{
    case getPage(page: Int)
    case getFrom(baseURL: URL)
}

extension MoyaTarget: TargetType{
   
    
    public var baseURL: URL{
        switch self{
        case .getPage: return URL(string: "https://swapi.co/api/people/")!
        case .getFrom(let base): return base
        }
    }
    
    public var path: String{
        switch self{
            case .getPage: return ""
            case .getFrom: return ""
        }
    }
  
    public var task: Task{
        switch self{
            case .getPage(let page):
                if(page == 1){
                    return .requestPlain
                }else{
                    return.requestParameters(parameters: ["page" : "\(page)"], encoding: URLEncoding.default)
                }
            case .getFrom : return .requestPlain
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
