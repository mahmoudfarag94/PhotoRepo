//
//  PhotoListResponseModel.swift
//  PhotosRepo
//
//  Created by Smart Zone on 5/12/22.
//

import Foundation
struct PhotoListResponseModel: Codable{
    var albumId:Int?
    var id:Int?
    var title:String?
    var url:String?
    var thumbnailUrl:String?
    
    enum CodingKeys:String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
        
    }
}
