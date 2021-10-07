//
//  AppConstants.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation

struct AppConstants {
    
    static func getApiBaseURL() -> String {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }
    
}
