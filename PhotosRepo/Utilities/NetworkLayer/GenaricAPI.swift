//
//  GenaricAPI.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/13/22.
//

import Foundation

class GenaricService{
    
    private init(){}
    static let shared = GenaricService()
    typealias HandlerResponse<T: Codable> = ((_ result: T? ,_ error:Error? ,_ statusCode:Int) -> ())
    
    func genariceAPI<T: Codable>(request: BaseRequest, completion: @escaping HandlerResponse<T>){
        BaseService.shared.performRequest(request: request) { response in
            
            switch response.result {
            case .success(_):
                do{
                    if let data = response.value?.data(using: .utf8){
                        let model = try JSONDecoder().decode(T.self, from: data)
                        print("model--===========\(model)")
                        completion(model , nil , response.response?.statusCode ?? 1001)
                    }
                }catch let error{
                    completion(nil, error, response.response?.statusCode ?? 1001)
                }
            case .failure(let error):
                completion(nil, error, response.response?.statusCode ?? 1001)
            }
        }
    }
}
