//
//  AppCoordinator.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation
import UIKit

class AppCoordinator {
    
    let container = CatsContainer()
    let navigationController = UINavigationController()
    
    func start() {
        let windowd = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        windowd?.rootViewController = self.navigationController
        
        let vc = self.container.resolveCatsListViewController()
        vc.coordinator = self
        self.navigationController.setViewControllers([vc], animated: true)
    }
}

extension AppCoordinator: CatsListCoordinatorProtocol {
    func navigateToFavoritesList() {
        self.navigationController.pushViewController(self.container.resolveFavoritesViewController(),
                                                     animated: true)
    }
}
