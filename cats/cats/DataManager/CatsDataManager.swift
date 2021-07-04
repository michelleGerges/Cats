//
//  CatsDataManager.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import UIKit

class CatsDataManager: NSObject {
    
    let UDK_FAVORITES = "UDK_FAVORITES"
    
    func saveData(_ data: Data, for key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getData(for key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
}

extension CatsDataManager: CatsDataManaeProtocol {
    
    func loadCachedFavorites() -> [FavoriteModel]? {
        
        do {
            if let data = self.getData(for: UDK_FAVORITES) {
                let favorites = try JSONDecoder().decode([FavoriteModel].self, from: data)
                return favorites
            }
            
        } catch {
            print("(\(error))")
        }
        
        return nil
    }
    
    func updateCachedFavorites(favorites: [FavoriteModel]?) {
        
        guard let favorites = favorites else { return }
        
        do {
            let data = try JSONEncoder().encode(favorites)
            self.saveData(data, for: UDK_FAVORITES)
        } catch {
            print("(\(error))")
        }
    }
    
    func save(favorite: FavoriteModel) {
        var favorits = self.loadCachedFavorites() ?? [FavoriteModel] ()
        favorits.append(favorite)
        self.updateCachedFavorites(favorites: favorits)
    }
    
    func delete(favoriteID: Double) {
        var favorites = self.loadCachedFavorites()
        favorites?.removeAll(where: {
            $0.id == favoriteID
        })
        self.updateCachedFavorites(favorites: favorites)
    }
}
