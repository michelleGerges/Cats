//
//  CatsViewModelProtocols.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import Foundation
import PromiseKit

protocol CatsServicesProtocol {
    func loadCats(page: Int, limit:Int) -> Promise<[CatModel]>
    func favoriteImage(imageId: String) -> Promise<FavoriteModel>
    func deleteFavorite(favoriteId: Double) -> Promise<FavoriteModel>
    func loadFavorites() -> Promise<[FavoriteModel]>
}

protocol CatsDataManaeProtocol {
    func loadCachedFavorites() -> [FavoriteModel]?
    func updateCachedFavorites(favorites: [FavoriteModel]?)
    func save(favorite: FavoriteModel)
    func delete(favoriteID: Double)
}
