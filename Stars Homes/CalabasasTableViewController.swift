//
//  CalabasasTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 25/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class CalabasasTableViewController: UITableViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView: ADBannerView?

    
    // MARK: - Properties
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
            
            Home(category:"Music", name:"Toni Braxton", URL: "https://en.wikipedia.org/wiki/Toni_Braxton", pinLatitude: 34.132097 , pinLongitude : -118.669100, pinDetail : "25281 Prado Del Grandioso, Calabasas", pinTitle: "Toni Braxton"),
            
        Home(category:"Film & TV", name:"Khloe Kardashian",URL: "https://en.wikipedia.org/wiki/Khlo%C3%A9_Kardashian", pinLatitude: 34.128589 , pinLongitude : -118.671428, pinDetail : "25202 Prado Del Grandioso, Calabasas", pinTitle: "Khloe Kardashian"),]
    
        
        
        
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
        if segue.identifier == "showDetailCalabasas" {
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
                })
            }
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

extension CalabasasTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension CalabasasTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}