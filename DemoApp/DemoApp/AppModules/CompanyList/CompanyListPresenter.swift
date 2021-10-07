//
//  CompanyListPresenter.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation

class CompanyListPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingCompanies(withName name:String) {
        interactor?.fetchCompanies(withName: name)
    }
    
}

extension CompanyListPresenter: InteractorToPresenterProtocol {
    
    func companiesFetchedSuccess(companiesModelArray: Array<CompanyListEntity>) {
        
        if companiesModelArray.isEmpty {
            view?.showNoInfoView(show: true)
            view?.showEmptySearchMessage()
            return
        }
        
        view?.showNoInfoView(show: false)
        view?.showCompanies(companiesArray: companiesModelArray)
    }
    
    func companiesFetchFailed(errorType: FetchErrorType) {
        view?.showNoInfoView(show: true)
        switch errorType {
        case .emptySearch:
            view?.showEmptySearchMessage()
            break
        case .errorSearch:
            view?.showErrorWithSearchMessage()
            break
        }
    }
    
}
