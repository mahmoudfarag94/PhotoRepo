//
//  NetworkConstant.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/13/22.
//

import Foundation

enum EnviromentType{
    case production
    case debuging
    
    func getEnviroment()->String{
        switch self {
        case .production:
            return "https://jsonplaceholder.typicode.com/"
        case .debuging:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
}



enum WebServices: String{
    
    case photo = "photos"
    
    func getEndPoint()->String{
        let base = EnviromentType.production.getEnviroment()
        print("base url - ---- \(base)")
        switch self {
        case .photo :
            return "\(String(describing: base))\(rawValue)"
        }
    }
}


