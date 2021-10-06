//
//  CompaniesSearchFlowCoordinator.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation
import UIKit

protocol CompaniesSearchFlowCoordinatorDependencies {
    func makeCompaniesListViewController() -> MainVC
}

final class CompaniesSearchFlowCoordinator {
    
    private weak var navController: UINavigationController?
    private let dependencies: CompaniesSearchFlowCoordinatorDependencies
    
    private weak var mainDashboardVC: UIViewController?
    
    init(navController: UINavigationController, dependencies: CompaniesSearchFlowCoordinatorDependencies) {
        self.navController = navController
        self.dependencies = dependencies
    }
    
    func start() {
        
    }
    
}
