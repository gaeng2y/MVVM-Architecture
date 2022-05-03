//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by gaeng on 2022/04/26.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var vm = AddCoffeeOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
}
