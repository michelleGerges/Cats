//
//  CatsListViewController.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import UIKit
import PromiseKit
import SkeletonView

class CatsListViewController: UIViewController {

    @IBOutlet private var catsCollectionView: UICollectionView!
    
    var viewModel: (CatsListViewModelProtocol & FavoriteViewModelProtocol)!
    var coordinator: CatsListCoordinatorProtocol!
    
    var cats = [CatModel] ()
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupCollectionView()
        self.setupLoadMore()
        
        self.view.showSkeleton()
        self.loadData(page: 1)
    }
    
    func setupNavigationBar() {
        
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "Favorites",
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(navigateToFavoritesList(_:)))
    }
    
    @objc
    func navigateToFavoritesList(_:Any) {
        self.coordinator.navigateToFavoritesList()
    }
    
    func setupCollectionView() {
        self.catsCollectionView.dataSource = self
        self.catsCollectionView.delegate = self
        self.catsCollectionView.registerNibFor(cellClass: CatCollectionViewCell.self)
        self.catsCollectionView.registerSkeleton(cellClass: CatCollectionViewCell.self)
    }
    
    func setupLoadMore() {
        self.catsCollectionView.setupLoadingMore {
            self.loadData(page: self.currentPage + 1)
        }
    }

    func loadData(page: Int, limit: Int = 10) {
        
        firstly {
            self.viewModel.getCats(page: page, limit: limit)
        }.done {
            self.cats.append(contentsOf: $0)
            self.currentPage = page
            self.catsCollectionView.reloadData()
        }.catch {
            AlertMessage.alertError($0.message)
        }.finally {
            self.catsCollectionView.endLoadingMoreAndRefreshing()
            self.view.hideSkeleton()
        }
    }
}

extension CatsListViewController: SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: CatCollectionViewCell.self, for: indexPath)
        cell.configure(self.cats[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CatCollectionViewCell.cellSkeletonIdentifier
    }
}

extension CatsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (collectionView.frame.width - flowlayout.minimumInteritemSpacing - flowlayout.sectionInset.left - flowlayout.sectionInset.right)  * 0.5
            return CGSize (width: width, height: width)
        }
        
        let width = collectionView.frame.width * 0.5
        return CGSize (width: width, height: width)
    }
}

extension CatsListViewController: CatCollectionViewCellDelegate {
    func catCollectionViewCell(_ cell: CatCollectionViewCell, didFavorite model: Favorable) {
        guard let model = model as? CatModel else { return }
        _ = firstly {
            self.viewModel.favoriteCat(cat: model)
        }.done { _ in
            //
        }.catch {
            AlertMessage.alertError($0.message)
            cell.reversFavoriteState(favorable: model) // return back to old state
        }
    }
    
    func catCollectionViewCell(_ cell: CatCollectionViewCell, didUnfavorite model: Favorable) {
        
        guard let model = model as? CatModel else { return }
        _ = firstly {
            self.viewModel.unfavorite(cat: model)
        }.done { _ in
            //
        }.catch {
            AlertMessage.alertError($0.message)
            cell.reversFavoriteState(favorable: model) // return back to old state
        }
    }
}
