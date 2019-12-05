//
//  ContactsandStockPricesData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Lilia Yudina on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Contacts: Codable {
    let results: [Information]
}
struct Information: Codable {
    let gender: String
    let name: FullName
    let location: Address
    let email: String
    let picture: Multimedia
}
struct FullName: Codable {
    let title: String
    let first: String
    let last: String
}
struct Address: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}
struct Multimedia: Codable {
    let large: String
    let medium: String
    let thumbnail: String
    
}
//extension Information {
//    var medium: Multimedia? {
//        return picture.medium 
//    }
//}
extension Contacts {
    static func getInformation () -> [Information] {
        var information = [Information]()
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else { fatalError("couldn not locate json file")}
        do {
            
            let data = try Data(contentsOf: fileURL)
            
            let informationData = try JSONDecoder().decode(Contacts.self, from: data)
            
            information = informationData.results
            
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return information
    }
}
