//
//  Constants.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/27.
//

import Foundation

struct Constants {
    struct Urls {
        static func urlForWeatherByCity(city: String) -> URL {
            let userDefaults = UserDefaults.standard
            let unit = (userDefaults.value(forKey: "unit") as? String) ?? "imperial"
            
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=12e8ad50c19f1a58d769c2103c169453&units=\(unit)")!
        }
    }
}


