//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/27.
//

import Foundation

class AddWeatherViewModel {
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
        let weatherURL = Constants.Urls.urlForWeatherByCity(city: city)
        
        let weatherResource = Resource<WeatherResponse>(url: weatherURL) { data in
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        }
        
        WebService().load(resource: weatherResource) { result in
            if let weatherResponse = result {
                let vm = WeatherViewModel(weather: weatherResponse)
                completion(vm)
            }
        }
    }
}
