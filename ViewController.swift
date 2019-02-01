//
//  ViewController.swift
//  contactList
//
//  Created by Candy on 31/01/2019.
//  Copyright © 2019 EPITA. All rights reserved.
//

import UIKit

private let url = URL(string: "https://randomuser.me/api/?results=18&seed=nguyen")!

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts: [Contact] = []
    var selectedContact: Contact?
    var searchedContacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Search by name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell {
            cell.load(searchedContacts[indexPath.row], index: indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedContacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedContact = self.searchedContacts[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if  let detailViewController = segue.destination as? DetailViewController {
                detailViewController.contact = self.selectedContact
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedContacts = searchText.count < 3 ? contacts : contacts.filter {
            $0.firstName.lowercased().contains(searchText.lowercased()) ||
            $0.lastName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    func fetchData() {
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard error == nil else {
                
                let alert = UIAlertController(
                    title: "Error when fetching data",
                    message: error?.localizedDescription,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                return
            }
        
            guard let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary else {
                print("Error")
                return
            }

            guard let results = json["results"] as? [NSDictionary] else{
                return
            }
            
            for result in results as [NSDictionary] {
                self.contacts.append(Contact(json: result))
            }

            self.searchedContacts = self.contacts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }

}

