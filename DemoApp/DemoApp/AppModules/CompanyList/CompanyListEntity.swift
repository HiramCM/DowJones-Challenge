//
//  CompanyListEntity.swift
//  DemoApp
//
//  Created by Hiram Castro Maldonado on 06/10/21.
//

import Foundation

struct CompanyListEntity: Decodable {
    
    let symbol:String?
    let companyName:String?
    let price:String?
    let priceClose:String?
    let priceChange:String?
    let volume:String?
    let pricePercentChange:String?
    let volumePercentChange:String?
    let quotePageLink:String?
    let footer:String?
    let extendedHours:String?
    
    private enum CodingKeys : String, CodingKey {
        case symbol = "Symbol"
        case companyName = "CompanyName"
        case price = "Price"
        case priceClose = "PriceClose"
        case priceChange = "PriceChange"
        case volume = "Volume"
        case pricePercentChange = "PricePercentChange"
        case volumePercentChange = "VolumePercentChange"
        case quotePageLink = "QuotePageLink"
        case footer = "Footer"
        case extendedHours = "ExtendedHours"
    }
    
}
