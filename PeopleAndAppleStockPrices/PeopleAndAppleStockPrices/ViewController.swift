//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit
enum NameSearch {
    case first
    case last
}
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contactSearch = NameSearch.first
    
    
    var information = [Information]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    var searchQuery = "" {
        didSet {
            switch contactSearch {
            case .first:
                information = Contacts.getInformation().filter {
                    $0.name.first.lowercased().contains(searchQuery.lowercased())
                }.sorted(by: {$0.name.first < $1.name.first})
            case .last:
                information = Contacts.getInformation().filter {
                    $0.name.last.lowercased().contains(searchQuery.lowercased())
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    func loadData() {
        information = Contacts.getInformation().sorted(by: {$0.name.first < $1.name.first})
    }
        func filterContacts(for searchText: String) {
            guard !searchText.isEmpty else { return }
            information = Contacts.getInformation().filter {
                $0.name.first.lowercased().contains(searchText.lowercased())
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("failed to get indexPath and detailViewController")
        }
        let chosenContact = information[indexPath.row]
        detailViewController.contact = chosenContact
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = information[indexPath.row]
        cell.textLabel?.text = ("\(contact.name.first.capitalized) \(contact.name.last.capitalized)")
        cell.detailTextLabel?.text = ("\(contact.location.street.capitalized) \(contact.location.city.capitalized), \(contact.location.state.capitalized)  \(contact.location.postcode.uppercased())")
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        
        searchQuery = searchText.lowercased()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            contactSearch = .first
        case 1:
            contactSearch = .last
        default:
            print("Not valid search")
        }
    }
}
