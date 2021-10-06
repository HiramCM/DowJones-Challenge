//
//  SearchCompaniesViewModel.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

struct SearchCompaniesViewModelActions {
    
}

protocol SearchCompaniesViewModelInput {
    func viewDidLoad()
}

protocol SearchCompaniesViewModelOutput {
    var isEmpty: Bool { get }
}

protocol SearchCompaniesViewModel: SearchCompaniesViewModelInput, SearchCompaniesViewModelOutput { }

final class DefaultSearchCompaniesViewModel: SearchCompaniesViewModel {
    
    private let searchCompaniesUseCase: SearchCompaniesUseCase
    
    private var companiesLoadTask: Cancellable? { willSet { companiesLoadTask?.cancel() } }
    
    //MARK: - OUTPUT
    var items: Observable<[CompanyModel]> = Observable([])
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    
    init(searchCompaniesUseCase: SearchCompaniesUseCase) {
        self.searchCompaniesUseCase = searchCompaniesUseCase
    }
    
    private func loadCompaniesData(searchQuery: SearchQuery) {
        companiesLoadTask = searchCompaniesUseCase.execute(requestValue: .init(query: searchQuery),
                                                           completion: { result in
            switch result {
            case .success(let companyModel):
                self.items.value = [companyModel]
                break
            case .failure(let error):
                self.handle(error: error)
                break
            }
        })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
    
}

extension DefaultSearchCompaniesViewModel {
    
    func viewDidLoad() { }
    
    func searching(query:String) {
        guard !query.isEmpty else { return }
        loadCompaniesData(searchQuery: SearchQuery(query: query))
    }
}
