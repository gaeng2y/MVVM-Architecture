//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/06.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    private var addWeatherVM = AddWeatherViewModel()
    
    var delegate: AddWeatherDelegate?
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func saveCityButtonPressed(_ sender: Any) {
        if let city = cityNameTextField.text {
            addWeatherVM.addWeather(for: city) { vm in
                self.delegate?.addWeatherDidSave(vm: vm)
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
