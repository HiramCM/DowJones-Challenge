//
//  CompanyProtocol.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation
import UIKit

enum FetchErrorType {
    case emptySearch
    case errorSearch
}

protocol CompanyListViewProtocol {
    func showEmptySearchMessage()
    func showErrorWithSearchMessage()
    func showNoInfoView(show:Bool)
}

protocol ViewToPresenterProtocol {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCompanies(withName name:String)
    func getTotalItems() -> Int
    func getItem(atRow row:Int) -> CompanyListEntity?
}

protocol PresenterToViewProtocol {
    func showCompanies(companiesArray:Array<CompanyListEntity>)
    func showEmptySearchMessage()
    func showErrorWithSearchMessage()
    func showNoInfoView(show:Bool)
}

protocol PresenterToRouterProtocol {
    static func createModule()-> CompanyListViewController
    func pushToMainScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchCompanies(withName name:String)
    func getTotalItems() -> Int
    func getItem(atRow row:Int) -> CompanyListEntity?
}

protocol InteractorToPresenterProtocol {
    func companiesFetchedSuccess(companiesModelArray:Array<CompanyListEntity>)
    func companiesFetchFailed(errorType: FetchErrorType)
}
