//
//  UIView+Skeleton.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import UIKit
import SkeletonView

extension UIView {
    func showSkeleton() {
        self.showAnimatedGradientSkeleton(usingGradient: SkeletonAppearance.default.gradient,
                                          animation: GradientDirection.topLeftBottomRight.slidingAnimation(),
                                          transition: SkeletonTransitionStyle.none)
    }
    
    func hideSkeleton() {
        self.hideSkeleton(reloadDataAfter: true,
                          transition: SkeletonTransitionStyle.crossDissolve(0.5))
    }
}

extension UICollectionView {
    
    func registerSkeleton(cellClass: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cellClass.cellNibName, bundle: nil),
                      forCellWithReuseIdentifier: cellClass.cellSkeletonIdentifier)
    }
}

extension UICollectionViewCell {
    
    static var cellSkeletonIdentifier: String {
        return self.cellIdentifier + "+Skeleton"
    }
    
    var isSkeletonCell: Bool {
        return (self.reuseIdentifier == Self.cellSkeletonIdentifier)
    }
}
