//
//  CompaniesSceneDIContainer.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import UIKit

final class CompaniesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - USE CASES
    
    func makeSearchCompaniesUseCase() -> SearchCompaniesUseCase {
        return DefaultSearchCompaniesUseCase(companiesRepository: makeCompaniesRepositories())
    }
    
    //MARK: - REPOSITORIES
    
    func makeCompaniesRepositories() -> CompaniesRepository {
        return DefaultCompaniesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    //MARK: - COMPANIES LIST
    
    func makeSearchCompaniesViewModel() -> SearchCompaniesViewModel {
        return DefaultSearchCompaniesViewModel(searchCompaniesUseCase: makeSearchCompaniesUseCase())
    }
    
    //MARK: - FLOW COORDINATOR
    func makeCompaniesSearchFlowCoordinator(navigationController: UINavigationController) -> CompaniesSearchFlowCoordinator {
        return CompaniesSearchFlowCoordinator(navController: navigationController, dependencies: self)
    }
}

extension CompaniesSceneDIContainer: CompaniesSearchFlowCoordinatorDependencies {
    func makeCompaniesListViewController() -> MainVC {
        return MainVC()
    }
}
