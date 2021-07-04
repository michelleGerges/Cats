//
//  FavoritesViewController.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import UIKit

import PromiseKit
import SkeletonView

class FavoritesViewController: UIViewController {

    @IBOutlet private var favoritesCollectionView: UICollectionView!
    
    var viewModel: FavoritesListViewModelProtocol!
    
    var favorites = [FavoriteModel] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupCollectionView()
        self.setupRefresh()
        
        self.view.showSkeleton()
        self.loadData()
    }
    
    func setupNavigationBar() {
        
        self.title = "My Favorites"
    }
    
    func setupCollectionView() {
        self.favoritesCollectionView.dataSource = self
        self.favoritesCollectionView.delegate = self
        self.favoritesCollectionView.registerNibFor(cellClass: CatCollectionViewCell.self)
        self.favoritesCollectionView.registerSkeleton(cellClass: CatCollectionViewCell.self)
    }
    
    func setupRefresh() {
        self.favoritesCollectionView.setupRefresh {
            self.loadData()
        }
    }

    func loadData() {
        
        firstly {
            self.viewModel.getUpdatedFavorites()
        }.done {
            self.favorites = $0
            self.favoritesCollectionView.reloadData()
        }.catch {
            AlertMessage.alertError($0.message)
        }.finally {
            self.favoritesCollectionView.endLoadingMoreAndRefreshing()
            self.view.hideSkeleton()
        }
    }
}

extension FavoritesViewController: SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: CatCollectionViewCell.self, for: indexPath)
        cell.configure(self.favorites[indexPath.item].image)
        cell.setAlwaysFavorite()
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CatCollectionViewCell.cellSkeletonIdentifier
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (collectionView.frame.width - flowlayout.minimumInteritemSpacing - flowlayout.sectionInset.left - flowlayout.sectionInset.right)
            return CGSize (width: width, height: width)
        }
        
        let width = collectionView.frame.width
        return CGSize (width: width, height: width)
    }
}
