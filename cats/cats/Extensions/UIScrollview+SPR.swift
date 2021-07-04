//
//  UIScrollview+PullToRefresh.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import SwiftPullToRefresh

extension UIScrollView {
    
    func refresh() {
        self.spr_beginRefreshing()
    }
    
    func setupRefresh(_ completion : @escaping () -> Void) {
        self.spr_setIndicatorHeader(action: completion)
    }
    
    func endLoadingMoreAndRefreshing() {
        self.spr_endRefreshing()
    }
    
    func setupLoadingMore(_ completion : @escaping () -> Void) {
        self.spr_setIndicatorAutoFooter(action: completion)
    }
}
