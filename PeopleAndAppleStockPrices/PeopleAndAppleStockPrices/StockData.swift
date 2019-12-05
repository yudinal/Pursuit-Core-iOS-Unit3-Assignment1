//
//  StockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockData {
    let date: String
    let open: Double
    let close: Double
    let label: String

    static let stocks = [StockData]()
    
    static func stockSections() -> [[StockData]] {
        let sortedStocks = stocks.sorted { $0.date > $1.date }
        let uniqueStocks = Set(sortedStocks.map {$0.date})
        let sections = Array(repeating: [StockData](), count: uniqueStocks.count)
        var currentIndex = 0
        var currentStock = sortedStocks.first?.date ?? "date"
        
        for stock in sortedStocks {
            if stock.date == currentStock {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentStock = stock.date
               sections[currentIndex].append(stock)
            }
        }
        return sections
    }
}
