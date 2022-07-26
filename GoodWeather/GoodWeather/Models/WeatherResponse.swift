//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/26.
//

import Foundation

/*
 {"coord":{"lon":-0.1257,"lat":51.5085},
 "weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],
 "base":"stations",
 "main":{"temp":70.38,"feels_like":69.6,"temp_min":66.85,"temp_max":73.36,"pressure":1019,"humidity":53},
 "visibility":10000,
 "wind":{"speed":3.44,"deg":0},
 "clouds":{"all":100},"dt":1658848233,"sys":{"type":2,"id":2075535,"country":"GB","sunrise":1658808905,"sunset":1658865521},"timezone":3600,"id":2643743,"name":"London","cod":200}
 */

struct WeatherResponse: Decodable {
    let name: String
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
