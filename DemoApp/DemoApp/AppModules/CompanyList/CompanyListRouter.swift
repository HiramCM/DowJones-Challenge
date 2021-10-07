//
//  CompanyListRouter.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation
import UIKit

class CompanyListRouter: PresenterToRouterProtocol {
    
    static var mainstoryboard: UIStoryboard {
            return UIStoryboard(name:"Main",bundle: Bundle.main)
        }
    
    static func createModule() -> CompanyListViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MyViewController") as! CompanyListViewController
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = CompanyListPresenter()
        var interactor: PresenterToInteractorProtocol = CompanyListInteractor()
        let router:PresenterToRouterProtocol = CompanyListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
                
        return view
    }
    
    func pushToMainScreen(navigationConroller: UINavigationController) {
        
    }
    
}
