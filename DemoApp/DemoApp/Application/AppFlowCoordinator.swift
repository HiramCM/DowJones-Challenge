//
//  AppFlowCoordinator.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let companiesSceneDIContainer = appDIContainer.makeCompaniesSceneDIContainer()
        let flow = companiesSceneDIContainer.makeCompaniesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
