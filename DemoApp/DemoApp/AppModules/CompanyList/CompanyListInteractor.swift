//
//  CompanyListInteractor.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation

class CompanyListInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    private let totalItems = 10
    private var companiesNewsArray:[CompanyListEntity]?
    
    func fetchCompanies(withName name: String) {
        
        guard !name.isEmpty else {
            presenter?.companiesFetchFailed(errorType: .emptySearch)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: AppConstants.getApiBaseURL().appending("\(name)/\(totalItems)"))!)
        { [weak self] data, response, error in
            do {
                let data = try JSONDecoder().decode([CompanyListEntity].self, from: data!)
                self?.presenter?.companiesFetchedSuccess(companiesModelArray: data)
            } catch {
                self?.presenter?.companiesFetchFailed(errorType: .errorSearch)
            }
        }.resume()
    }
    
    func getTotalItems() -> Int {
        return companiesNewsArray?.count ?? 0
    }
    
    func getItem(atRow row: Int) -> CompanyListEntity? {
        return companiesNewsArray?[row] ?? nil
    }
    
}
