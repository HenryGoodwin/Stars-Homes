//
//  BelAirTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 24/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class BelAirTableViewController: UITableViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView: ADBannerView?

    var detailViewController: DetailViewController? = nil
    var House = [Home]()
    var filteredHouse = [Home]()
    let searchController = UISearchController(searchResultsController: nil)
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV", "Music", "Sport", "Other"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        House = [
            
            Home(category:"Film & TV", name:"Nicolas Cage", URL: "https://en.wikipedia.org/wiki/Nicolas_Cage", pinLatitude : 34.0824042, pinLongitude : -118.4407743, pinDetail : "363 Copa De Oro Road, Bel Air", pinTitle: "Nicholas Cage"),
            
            Home(category:"Film & TV", name:"Nick Cannon", URL: "https://en.wikipedia.org/wiki/Nick_Cannon", pinLatitude: 34.129341 , pinLongitude : -118.463620, pinDetail : "3130 Antelo Rd, Bel Air", pinTitle: "Nick Cannon"),
            
            
            Home(category:"Music", name:"Mariah Carey", URL: "https://en.wikipedia.org/wiki/Mariah_Carey", pinLatitude: 34.129341 , pinLongitude : -118.463620, pinDetail : "3130 Antelo Rd, Bel Air", pinTitle: "Mariah Carey"),
            
            
             Home(category:"Film & TV", name:"Clint Eastwood", URL: "https://en.wikipedia.org/wiki/Clint_Eastwood", pinLatitude :34.084666, pinLongitude : -118.452541, pinDetail : "846 Stradella Road, Bel Air", pinTitle: "Clint Eastwood"),
            
            Home(category:"Music", name:"Michael Jackson", URL: "https://en.wikipedia.org/wiki/Michael_Jackson", pinLatitude : 34.080663, pinLongitude : -118.426146, pinDetail : "100 N. Carolwood Drive, Bel Air, Michael Jackson's Last Home", pinTitle: "Michael Jackson (1958-2009)"),
        
        Home(category:"Film & TV", name:"Mike Medavoy", URL: "https://en.wikipedia.org/wiki/Mike_Medavoy", pinLatitude: 34.082750 , pinLongitude :  -118.445913 , pinDetail : "638 Siena Way, Bel Air", pinTitle: "Mike Medavoy"),]
        
        
        
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
        if segue.identifier == "showDetailBA" {
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
                delay(0.5, closure: { () -> () in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })            }
        }
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
        NSLog("Ad Loaded")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.adBannerView?.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.adBannerView?.hidden = true
    }

    
}

extension BelAirTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension BelAirTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
