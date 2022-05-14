//
//  GenaricService.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/13/22.
//

import Foundation
import Alamofire

class BaseService {
    
    private init(){}
    static let shared = BaseService()
    func performRequest(request: BaseRequest, callbackString: @escaping ((AFDataResponse<String>) -> Void)){
        print("-path-\(request.path)","-method-\(request.method),-paramters- \(request.paramters)" )
        AF.request(request.path, method: request.method , parameters: request.paramters, encoding: request.encoding, headers: request.header)
            .responseString {(response) in
                switch response.result{
                case.failure(let error):
                    print("❌ Respons Error Details >>>> " + error.localizedDescription)
                    callbackString(response)
                case .success( _):
                    callbackString(response)
                }
            }
    }
}

