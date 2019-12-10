//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!


    var stocks = StockData.stockSections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func average(for arr: [StockData]) -> Double {
        var sum = 0.0
        var avg = 0.0
        for stock in arr {
            sum += stock.open
        }
        avg = sum / Double(arr.count)
        return avg
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailViewController = segue.destination as? StockDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name in the \"identity inspector\" ")
        }
        let stock = stocks[indexPath.section][indexPath.row]
        stockDetailViewController.stock = stock
    }

}


extension StockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return stocks[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockCell else {
            fatalError("Couldn't dequeue a stockSell")
        }
        let stock = stocks[indexPath.section][indexPath.row]
        //cell.configureCell(for: stock)
        cell.dateLabel.text = stock.date
        cell.priceLabel.text = stock.open.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let avg = average(for: stocks[section])
        let month = stocks[section].first?.label.components(separatedBy: " ").first ?? ""
        let year = stocks[section].first?.label.components(separatedBy: " ").last ?? ""
        
        return " \(month) - 20\(year)  average open: \(String(format: "%.2f", avg))"

    }
    
    
}
