//
//  UIView+imageUrl.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//


import UIKit
import Alamofire
import Kingfisher

extension UIImageView {
    
    func loadImageFromUrl(_ urlStr: String?,
                          placeholderImage: UIImage? = nil,
                          completion: (() -> Void)? = nil) {
        if let url = URL(string: urlStr ?? "") {
            self.kf.setImage(with: url,
                             placeholder: placeholderImage) { _ in
                                completion?()
            }
        }
    }
}

