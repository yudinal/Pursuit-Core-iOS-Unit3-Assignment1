//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: StockData?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let chosenStock = stock else {
            fatalError("stock is is nil, verify prepare(for segue: )")
        }
        dateLabel.text = chosenStock.date
        openLabel.text = chosenStock.open.description
        closeLabel.text = chosenStock.close.description
        
        if chosenStock.open > chosenStock.close {
          imageView.image = UIImage.init(named: "thumbsUp")!
            view.backgroundColor = .green
        } else {
           imageView.image = UIImage.init(named: "thumbsDown")!
            view.backgroundColor = .red
        }
        
    }


}
