//
//  CompaniesRepository.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

protocol CompaniesRepository {
    @discardableResult
    func fetchCampanies(query:SearchQuery, completion: @escaping (Result<CompanyModel, Error>) -> Void) -> Cancellable?
}
