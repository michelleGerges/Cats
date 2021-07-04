//
//  NetworkManager+cats.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation
import PromiseKit

extension NetworkManager: CatsServicesProtocol {
    
    func loadCats(page: Int, limit:Int) -> Promise<[CatModel]> {
        return self.catsProvider.requestItems(CatsAPIs.search(page: page, limit: limit))
    }
    
    func favoriteImage(imageId: String) -> Promise<FavoriteModel> {
        return self.catsProvider.requestItem(CatsAPIs.favorite(imageId: imageId))
    }
    
    func deleteFavorite(favoriteId: Double) -> Promise<FavoriteModel> {
        return self.catsProvider.requestItem(CatsAPIs.deleteFavorite(favoriteId: favoriteId))
    }
    
    func loadFavorites() -> Promise<[FavoriteModel]> {
        return self.catsProvider.requestItems(CatsAPIs.favoriteList)
    }
}

