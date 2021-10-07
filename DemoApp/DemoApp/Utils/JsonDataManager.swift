//
//  JsonDataManager.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 07/10/21.
//

import Foundation

class JsonDataManager {
    
    func readLocalJSONFile(forName name: String) -> Data? {
        
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        
        return nil
    }
    
    func parseJsonData<T:Decodable>(jsonData: Data, ofType type:T.Type) throws -> [T]? {
        do {
            let decodedData = try JSONDecoder().decode([T].self, from: jsonData)
            return decodedData
        } catch let error {
            throw error
        }
    }
    
}
