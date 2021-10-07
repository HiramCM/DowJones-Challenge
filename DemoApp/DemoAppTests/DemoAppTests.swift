//
//  DemoAppTests.swift
//  DemoAppTests
//
//  Created by Hiram Castro Maldonado on 30/09/21.
//

import XCTest
@testable import DemoApp

class DemoAppTests: XCTestCase {
    
    let view = ViewControllerMock()
    var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = CompanyListPresenter()
    var interactor = InteractorMock()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        interactor.fetchCompanies(withName: "B")
        XCTAssertNotNil(view.companiesNewsArray)
        XCTAssertEqual(view.companiesNewsArray?.count, 10)
        XCTAssertEqual(view.showingErrorMessage, false)
        XCTAssertEqual(view.showingEmptyMessage, false)
        XCTAssertEqual(view.showingInfoView, false)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class ViewControllerMock:PresenterToViewProtocol {
    
    var presenter:ViewToPresenterProtocol?
    
    var companiesNewsArray:[CompanyListEntity]?
    
    var showingEmptyMessage = false
    var showingErrorMessage = false
    var showingInfoView = false
    
    func showCompanies(companiesArray: Array<CompanyListEntity>) {
        companiesNewsArray?.removeAll()
        companiesNewsArray = companiesArray
    }
    
    func showEmptySearchMessage() {
        showingEmptyMessage = true
    }
    
    func showErrorWithSearchMessage() {
        showingErrorMessage = true
    }
    
    func showNoInfoView(show: Bool) {
        showingInfoView = show
        showingEmptyMessage = show
        showingErrorMessage = show
    }
    
}

class InteractorMock: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    private let totalItems = 10
    
    private var companiesNewsArray:[CompanyListEntity]?
    
    func fetchCompanies(withName name: String) {
        
        if name.isEmpty {
            presenter?.companiesFetchFailed(errorType: .emptySearch)
            return
        }
        
        var fileName = ""
        
        if name.contains("A") {
            fileName = "MockDataA"
        } else if name.contains("B") {
            fileName = "MockDataB"
        } else {
            presenter?.companiesFetchFailed(errorType: .errorSearch)
            return
        }
        
        let jsonData = JsonDataManager().readLocalJSONFile(forName: fileName)
        if let data = jsonData {
            
            do {
                let parsedData = try JsonDataManager().parseJsonData(jsonData: data, ofType: CompanyListEntity.self)
                companiesNewsArray?.removeAll()
                companiesNewsArray = parsedData
                presenter?.companiesFetchedSuccess(companiesModelArray: companiesNewsArray!)
            } catch {
                presenter?.companiesFetchFailed(errorType: .errorSearch)
            }
            
        }
    }
    
}
