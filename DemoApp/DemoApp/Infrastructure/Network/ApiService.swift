//
//  ApiService.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 04/10/21.
//

import Foundation

protocol ApiRepositoryProtocol {
    func networkCall<T:Decodable>(url:URL, type:T.Type, completion: @escaping (_ error:Error?, _ myObj:[T]?) -> ())
}

class ApiService: ApiRepositoryProtocol {
    func networkCall<T>(url: URL, type: T.Type, completion: @escaping (Error?, [T]?) -> ()) where T : Decodable {
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let data = try JSONDecoder().decode([T].self, from: data!)
                completion(nil, data)
            } catch let error {
                completion(error, nil)
            }
        }.resume()
    }
}
