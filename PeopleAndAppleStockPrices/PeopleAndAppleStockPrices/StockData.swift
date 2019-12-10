//
//  StockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockData: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String

    static let stocks = [StockData]()
    
    static func stockSections() -> [[StockData]] {
        
        let sortedStocks = getStocks()
//        let uniqueStocks = Set(sortedStocks.map {$0.date})
        var uniqueStocks = Set<String>()
        
        for stock in sortedStocks{
            var label = stock.label
            var section = label.components(separatedBy: " ")
            section.remove(at: 1)
            label = section.joined()
            uniqueStocks.insert(label)
        }
        var sections = Array(repeating: [StockData](), count: uniqueStocks.count)
        var currentIndex = 0
        var currentStock = sortedStocks.first?.label.components(separatedBy: " ").first ?? "date"
        
        
        
        for stock in sortedStocks {
            let month = stock.label.components(separatedBy: " ").first ?? ""
            if month == currentStock {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentStock = stock.label.components(separatedBy: " ").first ?? ""
               sections[currentIndex].append(stock)
            }
        }
        return sections
        
 
        
    }
}
extension StockData {
    static func getStocks() -> [StockData] {
        var stock = [StockData]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else { fatalError("couldn't locate the json file")
            
        }
            do {
               let data = try Data(contentsOf: fileURL)
                let stockData = try JSONDecoder().decode([StockData].self, from: data)
                stock = stockData
            } catch {
                fatalError("failed to load contents of \(error)")
            }
            return stock
    }
}

