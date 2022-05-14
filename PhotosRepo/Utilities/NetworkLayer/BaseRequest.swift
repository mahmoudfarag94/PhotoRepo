//
//  BaseRequest.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/13/22.
//

import Foundation
import Alamofire

class BaseRequest{
   
    var path:String
    var method:HTTPMethod = .get
    var paramters:[String:Any]? = nil
    var header:HTTPHeaders? = nil
    var encoding:ParameterEncoding
    
    internal init(path: String, method: HTTPMethod = .get, paramters: [String : Any]? = nil, header: [String : String]? = nil) {
        self.path = path
        self.method = method
        self.paramters = paramters
        self.header = HTTPHeaders(header ?? [:])
        switch method {
        case .get:
            encoding = URLEncoding.default
        case.post:
            encoding = JSONEncoding.default
        default:
            encoding = JSONEncoding.default
        }
    }
}
