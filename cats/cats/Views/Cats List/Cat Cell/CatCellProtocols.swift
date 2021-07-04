//
//  CatCellProtocols.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import Foundation

protocol CatCollectionViewCellViewModelProtocol {
    var catImageUrl: String? { get }
}

protocol Favorable {
    var identifier: String? { get }
    var isFavorited: Bool { get }
    func reverseFavorite()
}

protocol CatCollectionViewCellDelegate {
    func catCollectionViewCell(_ cell: CatCollectionViewCell, didFavorite model: Favorable)
    func catCollectionViewCell(_ cell: CatCollectionViewCell, didUnfavorite model: Favorable)
}
