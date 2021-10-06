//
//  MainVM.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 04/10/21.
//

import Foundation

protocol CompaniesNewsVM {
    associatedtype Repo
    init(withRepository repo:Repo)
}

class MainVM:CompaniesNewsVM {
    
    typealias Repo = ApiRepositoryProtocol
    private let repo:ApiRepositoryProtocol
    private let totalItems = 10
    private var companiesNewsArray:[CompanyModel]?
    
    required init(withRepository repo: ApiRepositoryProtocol) {
        self.repo = repo
    }
    
    func getCompaniesCount() -> Int {
        return companiesNewsArray?.count ?? 0
    }
    
    func getCompany(at index:Int) -> CompanyModel? {
        return companiesNewsArray?[index] ?? nil
    }
    
    func getCompanies(startingWith name:String, completion: @escaping (Error?) -> Void) {
        self.repo.networkCall(url: URL(string: "https://myibd.investors.com/searchapi/predictivesearch/\(name)/\(totalItems)")!,
                              type: CompanyModel.self) { [weak self] error, myObj in
            if let error = error {
                completion(error)
            } else {
                self?.companiesNewsArray?.removeAll()
                self?.companiesNewsArray = myObj
                completion(nil)
            }
        }
    }
}
