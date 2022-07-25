//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/06.
//

import UIKit

class AddWeatherCityViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func saveCityButtonPressed(_ sender: Any) {
        if let city = cityNameTextField.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=12e8ad50c19f1a58d769c2103c169453&units=imperial")!
            
            let weatherResource = Resource<Any>(url: weatherURL) { data in
                return data
            }
            
            WebService().load(resource: weatherResource) { result in
                
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
