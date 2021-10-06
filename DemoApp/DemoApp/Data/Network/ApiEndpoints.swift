//
//  ApiEndpoints.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 05/10/21.
//

import Foundation

struct APIEndpoints {
    
    static func getCompanies(withName name:String) -> Endpoint<CompanyModel> {
        return Endpoint(path: "/searchapi/predictivesearch/\(name)/\(10)", method: .get)
    }
    
}
