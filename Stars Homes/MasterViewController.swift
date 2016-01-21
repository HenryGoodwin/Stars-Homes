//
//  MasterViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 5/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var House = [Home]()
    var filteredHouse = [Home]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Hollywood", "Beverly Hills", "Other"]
        tableView.tableHeaderView = searchController.searchBar

        
        House = [
            Home(category:"Hollywood", name:"Madonna", URL: "http://www.imdb.com/name/nm0000187/", pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: "Madonna (1958 - Present)"),
            
            Home(category:"Beverly Hills", name:"Elvis Presley", URL: "http://www.imdb.com/name/nm0000062/", pinLatitude: 34.097919 , pinLongitude : -118.3969712, pinDetail : "Elvis lived here from November 1967 until sometime in 1970", pinTitle: "Elvis Presley (1935-1977)"),

            Home(category:"Chocolate", name:"Dark Chocolate", URL: "", pinLatitude : 0, pinLongitude : 0, pinDetail : "", pinTitle: ""),

            Home(category:"Hard", name:"Lollipop", URL: "", pinLatitude: 61, pinLongitude : 0, pinDetail : "", pinTitle: ""),
            
            Home(category:"Hard", name:"Candy Cane", URL: "", pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: ""),
            
            Home(category:"Hard", name:"Jaw Breaker", URL: ""  , pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: ""),
            
            Home(category:"Other", name:"Caramel", URL: "", pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: ""),
            
            Home(category:"Other", name:"Sour Chew",URL: "", pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: ""),
            
            Home(category:"Other", name:"Gummi Bear", URL: "", pinLatitude: 0 , pinLongitude : 0, pinDetail : "", pinTitle: "")]
        
        
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredHouse.count
        }
        return House.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let house: Home
        if searchController.active && searchController.searchBar.text != "" {
            house = filteredHouse[indexPath.row]
        } else {
            house = House[indexPath.row]
        }
        cell.textLabel!.text = house.name
        cell.detailTextLabel!.text = house.category
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredHouse = House.filter({( candy : Home) -> Bool in
            let categoryMatch = (scope == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let house: Home
                if searchController.active && searchController.searchBar.text != "" {
                    house = filteredHouse[indexPath.row]
                } else {
                    house = House[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailHouse = house
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

extension MasterViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension MasterViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}