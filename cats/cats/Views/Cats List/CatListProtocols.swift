//
//  CatListProtocols.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import Foundation
import PromiseKit

protocol CatsListViewModelProtocol {
    func getCats(page: Int, limit: Int) -> Promise<[CatModel]>
}

protocol FavoriteViewModelProtocol {
    func favoriteCat(cat: CatModel) -> Promise<Double>
    func unfavorite(cat: CatModel) -> Promise<Void>
}

protocol FavoritesListViewModelProtocol {
    func getUpdatedFavorites() -> Promise<[FavoriteModel]>
}

protocol CatsListCoordinatorProtocol {
    func navigateToFavoritesList()
}
