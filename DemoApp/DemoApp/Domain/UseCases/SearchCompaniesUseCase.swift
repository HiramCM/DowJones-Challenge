//
//  SearchCompaniesUseCase.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

protocol SearchCompaniesUseCase {
    func execute(requestValue: SearchCompaniesUseCaseRequestValue, completion: @escaping (Result<CompanyModel, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchCompaniesUseCase:SearchCompaniesUseCase {
    
    private let companiesRepository:CompaniesRepository
    
    init(companiesRepository:CompaniesRepository) {
        self.companiesRepository = companiesRepository
    }
    
    func execute(requestValue: SearchCompaniesUseCaseRequestValue, completion: @escaping (Result<CompanyModel, Error>) -> Void) -> Cancellable? {
        return companiesRepository.fetchCampanies(query: requestValue.query) { result in
            completion(result)
        }
    }
    
}

struct SearchCompaniesUseCaseRequestValue {
    let query:SearchQuery
}
