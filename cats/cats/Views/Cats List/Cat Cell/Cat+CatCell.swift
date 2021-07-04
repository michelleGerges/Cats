//
//  Cat+CatCellProtocols.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import Foundation

extension CatModel: Favorable {
    
    var identifier: String? {
        return self.id
    }
    
    var isFavorited: Bool {
        self.beingFavorited
    }
    
    func reverseFavorite() {
        self.beingFavorited = !self.beingFavorited
    }
}

extension CatModel: CatCollectionViewCellViewModelProtocol {
    var catImageUrl: String? {
        return self.url
    }
}
