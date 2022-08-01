//
//  StockListViewModel.swift
//  StocksAppSwiftUI
//
//  Created by gaeng on 2022/08/01.
//

import Foundation

class StockListViewModel: ObservableObject {
    var searchTerm: String = ""
    @Published var stocks: [StockViewModel] = [StockViewModel]()
    
    func load() {
        fetchStocks()
    }
    
    private func fetchStocks() {
        WebService().getStocks { stocks in
            if let stocks = stocks {
                DispatchQueue.main.async {
                    self.stocks = stocks.map(StockViewModel.init)
                }
            }
        }
    }
}

