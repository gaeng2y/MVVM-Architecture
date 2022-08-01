//
//  Stock.swift
//  StocksAppSwiftUI
//
//  Created by gaeng on 2022/08/01.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
    let change: String 
}
