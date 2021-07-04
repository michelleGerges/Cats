//
//  FavoriteModel.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import UIKit

class FavoriteModel: NSObject, Codable {

    var id: Double?
    var user_id: String?
    var image_id: String?
    var created_at: String?
    var image: CatModel?
    
    enum CodingKeys: String, CodingKey {
        case id, user_id, image_id, created_at, image
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Double.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        image_id = try values.decodeIfPresent(String.self, forKey: .image_id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        image = try values.decodeIfPresent(CatModel.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(user_id, forKey: .user_id)
        try container.encodeIfPresent(image_id, forKey: .image_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(image, forKey: .image)
    }
}

/*
 {
        "id": 2093540,
         "user_id": "gd3qz2",
         "image_id": "hRWS4y5qu",
         "created_at": "2021-07-03T20:49:17.000Z",
         "image": {
             "id": "hRWS4y5qu",
             "url": "https://cdn2.thecatapi.com/images/hRWS4y5qu.png"
         }
 }
 */
