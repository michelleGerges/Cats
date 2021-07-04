//
//  CatCollectionViewCell.swift
//  cats
//
//  Created by michelle gergs on 04/07/2021.
//

import UIKit
import FaveButton

class CatCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var catImageView: UIImageView!
    @IBOutlet private var favoriteButton: FaveButton!
    
    var viewModel: (CatCollectionViewCellViewModelProtocol & Favorable)?
    var delegate: CatCollectionViewCellDelegate?
    
    func configure(_ viewModel: (CatCollectionViewCellViewModelProtocol & Favorable)?) {
        self.viewModel = viewModel
        self.catImageView.loadImageFromUrl(viewModel?.catImageUrl)
        self.favoriteButton.setSelected(selected: viewModel?.isFavorited ?? false, animated: false)
    }

    @IBAction func favoriteAction(_:Any) {
        
        guard let viewModel = self.viewModel else { return }
        
        viewModel.reverseFavorite()
        self.favoriteButton.setSelected(selected: viewModel.isFavorited, animated: true)
        
        if viewModel.isFavorited {
            self.delegate?.catCollectionViewCell(self, didFavorite: viewModel)
        } else {
            self.delegate?.catCollectionViewCell(self, didUnfavorite: viewModel)
        }
    }
    
    func reversFavoriteState(favorable: Favorable) {
        guard let viewModel = self.viewModel,
              favorable.identifier == viewModel.identifier else { return } // check same cat model
        
        viewModel.reverseFavorite()
        self.favoriteButton.setSelected(selected: viewModel.isFavorited, animated: false)
    }
    
    func setAlwaysFavorite() {
        self.favoriteButton.isEnabled = false
        self.favoriteButton.setSelected(selected: true, animated: false)
    }
}
