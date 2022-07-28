//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/06.
//

import UIKit

class WeatherListTableViewController: UITableViewController {
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Unit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let userDefault = UserDefaults.standard
        if let value = userDefault.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == "SettingTableViewController" {
            prepareSegueForSettingTableViewController(segue: segue)
        }
    }
    
    func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityViewController not found")
        }
        
        addWeatherCityVC.delegate = self
    }
    
    func prepareSegueForSettingTableViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let settingTVC = nav.viewControllers.first as? SettingTableViewController else {
            fatalError("AddWeatherCityViewController not found")
        }
        
        settingTVC.delegate = self
    }
    
    // MARK: - Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let weatherVM = weatherListViewModel.modelAt(row)
        cell.configure(weatherVM)
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        tableView.reloadData()
    }
}

extension WeatherListTableViewController: SettingDelegate {
    func settingDone(vm: SettingViewModel) {
        if lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
            self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)!
        }
    }
}
