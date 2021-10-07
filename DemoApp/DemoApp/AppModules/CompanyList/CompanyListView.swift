//
//  ViewController.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 30/09/21.
//

import UIKit

class CompanyListViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var CompaniesTableView: UITableView!
    
    @IBOutlet weak var CoverView: UIView!
    @IBOutlet weak var MessageLabel: UILabel!
    
    var presenter:ViewToPresenterProtocol?
    
    private var companiesNewsArray:[CompanyListEntity]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        
        showEmptySearchMessage()
        
        SearchBar.delegate = self
        CompaniesTableView.delegate = self
        CompaniesTableView.dataSource = self
    }
    
}

extension CompanyListViewController: PresenterToViewProtocol {
    
    func showCompanies(companiesArray: Array<CompanyListEntity>) {
        
        companiesNewsArray?.removeAll()
        companiesNewsArray = companiesArray
        
        DispatchQueue.main.async {
            self.CompaniesTableView.reloadData()
        }
    }
    
    func showEmptySearchMessage() {
        DispatchQueue.main.async {
            self.MessageLabel.text = "Type the company name to start searching."
        }
    }
    
    func showErrorWithSearchMessage() {
        DispatchQueue.main.async {
            self.MessageLabel.text = "Sorry, we couldn't find data for this search."
        }
    }
    
    func showNoInfoView(show: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.05, animations: {
                self.CoverView.alpha = show ? 1 : 0
            })
        }
    }
    
}

extension CompanyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companiesNewsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as? CompanyCell
        else {
            return UITableViewCell()
        }
        
        cell.bind(with: companiesNewsArray?[indexPath.row])
        
        return cell
    }
    
}

extension CompanyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
}

extension CompanyListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.startFetchingCompanies(withName: searchText)
    }
}
