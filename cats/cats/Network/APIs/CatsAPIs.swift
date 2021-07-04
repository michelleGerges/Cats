//
//  CatsAPIs.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Moya

enum CatsAPIs {
    case search(page: Int, limit: Int)
    case favorite(imageId: String)
    case deleteFavorite(favoriteId: Double)
    case favoriteList
}

extension CatsAPIs: TargetType {
    
    var baseURL: URL {
        guard let url = URL (string: WebServices.BaseUrl) else {
            fatalError("invalid base url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return WebServices.Endpoints.Search
        case .favorite:
            return WebServices.Endpoints.Favourites
        case .deleteFavorite(let favoriteId):
            return WebServices.Endpoints.Favourites+"/\(favoriteId)"
        case .favoriteList:
            return WebServices.Endpoints.Favourites
        }
    }
    
    var method: Method {
        switch self {
        case .search:
            return .get
        case .favorite:
            return .post
        case .deleteFavorite:
            return .delete
        case .favoriteList:
            return .get
        }
    }
    
    var sampleData: Data {
        Data ()
    }
    
    var task: Task {
        switch self {
        case .search(let page, let limit):
            return Task.requestParameters(parameters: ["page": page,
                                                       "limit": limit,
                                                       "order": "desc"],
                                          encoding: URLEncoding.default)
        case .favorite(let imageId):
            return Task.requestParameters(parameters: ["image_id": imageId],
                                          encoding: JSONEncoding.default)
        case .deleteFavorite:
            return Task.requestPlain
        case .favoriteList:
            return Task.requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["x-api-key": WebServices.apiKey]
    }
}
