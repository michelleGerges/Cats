//
//  CatModel.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import UIKit

class CatModel: NSObject, Codable {
    
    var id: String?
    var url: String?
    var width: Double?
    var height: Double?
    
    var favoriteId: Double? // setted by cach, not api
    var beingFavorited = false // flag to indicate is being favorited, until load favoriteId value from api
    
    // caching
    enum CodingKeys: String, CodingKey {
        case id, url, width, height
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Double.self, forKey: .width)
        height = try values.decodeIfPresent(Double.self, forKey: .height)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(width, forKey: .width)
        try container.encodeIfPresent(height, forKey: .height)
    }
}

/*
 {
 "breeds": [],
 "id": "a1d",
 "url": "https://cdn2.thecatapi.com/images/a1d.gif",
 "width": 341,
 "height": 281
 }
 */

