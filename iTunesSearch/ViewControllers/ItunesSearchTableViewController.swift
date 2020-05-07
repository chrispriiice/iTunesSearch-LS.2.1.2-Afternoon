//
//  ItunesSearchTableViewController.swift
//  iTunesSearch
//
//  Created by Lambda_School_Loaner_201 on 3/14/20.
//  Copyright © 2020 BuildWeek1x2. All rights reserved.
//

import UIKit

class ItunesSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchResultController = SearchResultController()
    
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
    
        var resultType: ResultType!
        
        switch resultTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        searchResultController.performSearch(for: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        let searchResult = searchResultController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.artist

        return cell
    }
}
