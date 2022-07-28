//
//  SettingTableViewController.swift
//  GoodWeather
//
//  Created by gaeng on 2022/07/27.
//

import UIKit

protocol SettingDelegate {
    func settingDone(vm: SettingViewModel)
}

class SettingTableViewController: UITableViewController {
    private var settingViewModel = SettingViewModel()
    var delegate: SettingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func done() {
        if let delegate = self.delegate {
            delegate.settingDone(vm: settingViewModel)
        }
        
        self.dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // uncheck all cells
        tableView.visibleCells.forEach {
            $0.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            settingViewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingItem = settingViewModel.units[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = settingItem.displayName
        
        if settingItem == settingViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}
