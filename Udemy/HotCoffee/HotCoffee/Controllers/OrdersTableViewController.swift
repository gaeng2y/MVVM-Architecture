//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by gaeng on 2022/04/26.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        WebsService().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
