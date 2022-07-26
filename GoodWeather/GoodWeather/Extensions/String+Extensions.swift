//
//  String+Extensions.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/27.
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
