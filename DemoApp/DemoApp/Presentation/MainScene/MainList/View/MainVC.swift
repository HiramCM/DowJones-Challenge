//
//  ViewController.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 30/09/21.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var CompaniesTableView: UITableView!
    
    @IBOutlet weak var CoverView: UIView!
    @IBOutlet weak var MessageLabel: UILabel!
    
    private let vm = MainVM(withRepository: ApiService())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showEmptySearchMessage()
        
        SearchBar.delegate = self
        CompaniesTableView.delegate = self
        CompaniesTableView.dataSource = self
    }
    
    private func showEmptySearchMessage() {
        DispatchQueue.main.async {
            self.MessageLabel.text = "Type the company name to start searching."
        }
    }
    
    private func showErrorWithSearchMessage() {
        DispatchQueue.main.async {
            self.MessageLabel.text = "Sorry, we couldn't find data for this search."
        }
    }
    
    private func showNoInfoView(show:Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.05, animations: {
                self.CoverView.alpha = show ? 1 : 0
            })
        }
    }
    
    private func getCompanies(withName name:String) {
        
        if name.isEmpty {
            showEmptySearchMessage()
            showNoInfoView(show: true)
            return
        }
        
        
        vm.getCompanies(startingWith: name, completion: { [weak self] error in
            if error != nil {
                self?.showErrorWithSearchMessage()
                self?.showNoInfoView(show: true)
                return
            } else {
                DispatchQueue.main.async {
                    self?.showNoInfoView(show: false)
                    self?.CompaniesTableView.reloadData()
                }
                return
            }
        })
    }
    
}

extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getCompaniesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as? CompanyCell
        else {
            return UITableViewCell()
        }
        
        cell.bind(with: vm.getCompany(at: indexPath.row))
        
        return cell
    }
    
}

extension MainVC: UITableViewDelegate {
    
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

extension MainVC:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getCompanies(withName: searchText)
    }
}
