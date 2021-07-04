//
//  ServerError.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation

class ServerError: NSObject, Codable {
    
    var message: String?
    var status: Int?
    var level: String?
    
    enum CodingKeys: String, CodingKey {
        case message, status, level
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        level = try values.decodeIfPresent(String.self, forKey: .level)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(level, forKey: .level)
    }
}

/*
 {
     "message": "INVALID_ACCOUNT",
     "status": 400,
     "level": "info"
 }
 */
