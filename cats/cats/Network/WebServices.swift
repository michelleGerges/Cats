//
//  WebServices.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation

struct WebServices {
    static let BaseUrl = "https://api.thecatapi.com/"
    
    struct Endpoints {
        static let Search = "v1/images/search"
        static let Favourites = "v1/favourites"
    }
    
    static let apiKey = "8d3a969c-6391-423e-a3d9-4afa68ad0760"
}
