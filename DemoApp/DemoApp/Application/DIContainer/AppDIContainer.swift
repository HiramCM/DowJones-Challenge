//
//  AppDIContainer.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    //MARK: - NETWORK
    
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }() as DataTransferService
    
    //MARK: - DIContainers of scenes
    
    func makeCompaniesSceneDIContainer() -> CompaniesSceneDIContainer {
        let dependencies = CompaniesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return CompaniesSceneDIContainer(dependencies: dependencies)
    }
    
}
