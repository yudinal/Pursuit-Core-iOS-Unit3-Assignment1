//
//  DetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var contact: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI () {
        guard let chosenContact = contact else {
            fatalError(" contact is nil, verify prepare(for segue: )")
        }
        nameLabel.text = ("\(chosenContact.name.first.capitalized) \(chosenContact.name.last.capitalized)")
        addressLabel.text = ("\(chosenContact.location.street.capitalized) \(chosenContact.location.city.capitalized), \(chosenContact.location.state.capitalized)  \(chosenContact.location.postcode.uppercased())")
        emailLabel.text = chosenContact.email
        
        if let mainImage = contact?.picture {
            ContactImage.fetchImage(for: mainImage.medium) {[unowned self] (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
        }
    }

}
}
}
