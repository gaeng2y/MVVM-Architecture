//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/27.
//

import Foundation

extension Double {
    func formatAsDegree() -> String {
        return String(format: "%.0f°", self)
    }
}
