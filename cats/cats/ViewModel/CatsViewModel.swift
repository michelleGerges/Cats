//
//  CatsViewModel.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import PromiseKit

class CatsViewModel: NSObject {
    
    var apiClient: CatsServicesProtocol!
    var dataManager: CatsDataManaeProtocol!
    
    func setFavorites(favorites: [FavoriteModel], toCats cats: [CatModel]) -> Guarantee <[CatModel]>{
        return Guarantee<[CatModel]> {
            
            favorites.forEach { favorite in
                cats.forEach { cat in
                    if cat.id == favorite.image_id  || cat.id == favorite.image?.id {
                        cat.favoriteId = favorite.id
                        cat.beingFavorited = true
                    }
                }
            }
            
            $0(cats)
        }
    }
    
    func loadFavorites() -> Promise<[FavoriteModel]> {
        if let favorites = self.dataManager.loadCachedFavorites(), !favorites.isEmpty {
            return Promise<[FavoriteModel]> { $0.fulfill(favorites) }
        }
        
        return firstly {
            self.apiClient.loadFavorites()
        }.get {
            self.dataManager.updateCachedFavorites(favorites: $0)
        }
    }
}

extension CatsViewModel: CatsListViewModelProtocol {
    
    func getCats(page: Int, limit: Int) -> Promise<[CatModel]> {
        
        firstly {
            when(fulfilled: self.apiClient.loadCats(page: page, limit: limit), self.loadFavorites())
        }.then {
            self.setFavorites(favorites: $1, toCats: $0)
        }
    }
}

extension CatsViewModel: FavoriteViewModelProtocol {
    func favoriteCat(cat: CatModel) -> Promise<Double> {
        
        firstly {
            self.apiClient.favoriteImage(imageId: cat.id ?? "")
        }.get {
            cat.favoriteId = $0.id
            $0.image = cat
            $0.image_id = cat.id
            self.dataManager.save(favorite: $0)
        }.map {
            return $0.id ?? 0
        }
    }
    
    func unfavorite(cat: CatModel) -> Promise<Void> {
        firstly {
            self.apiClient.deleteFavorite(favoriteId: cat.favoriteId ?? 0)
        }.get { _ in
            cat.favoriteId = nil
            self.dataManager.delete(favoriteID: cat.favoriteId ?? 0)
        }.asVoid()
    }
}

extension CatsViewModel: FavoritesListViewModelProtocol {
    
    func getUpdatedFavorites() -> Promise<[FavoriteModel]> {
        
        return Promise<[FavoriteModel]> { resolver in
            
            if let favorites = self.dataManager.loadCachedFavorites(), !favorites.isEmpty {
                resolver.fulfill(favorites)
            }
            
            firstly {
                self.refreshFavorites()
            }.done {
                resolver.fulfill($0)
            }.catch {
                resolver.reject($0)
            }
        }
    }
    
    func refreshFavorites() -> Promise<[FavoriteModel]> {
        firstly {
            self.apiClient.loadFavorites()
        }.get {
            self.dataManager.updateCachedFavorites(favorites: $0)
        }
    }
}
