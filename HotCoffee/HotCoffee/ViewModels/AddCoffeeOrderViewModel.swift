//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by gaeng on 2022/05/02.
//

import Foundation

struct AddCoffeeOrderViewModel {
    var name: String?
    var email: String?
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
