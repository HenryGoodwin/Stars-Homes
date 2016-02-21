//
//  MasterViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 5/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class MasterViewController: UITableViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView: ADBannerView?
    
    // MARK: - Properties
    var detailViewController: DetailViewController? = nil
    var House = [Home]()
    var filteredHouse = [Home]()
    let searchController = UISearchController(searchResultsController: nil)
    
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
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV", "Music", "Sport", "Icon", "Other"]
        tableView.tableHeaderView = searchController.searchBar

        
        House = [
            //Beverly Hills
            //Madonna
            
            Home(category:"Other", name:"Christian Audigier", URL: "https://en.wikipedia.org/wiki/Christian_Audigier", pinLatitude: 34.063654 , pinLongitude : -118.329737, pinDetail : "600 S Muirfield Rd, Beverly Hills", pinTitle: "Christian Audigier"),
            
            Home(category:"Film & TV", name:"Hank Azaria", URL: "https://en.wikipedia.org/wiki/Hank_Azaria", pinLatitude: 34.110087 , pinLongitude : -118.418868, pinDetail : "2120 N Beverly Dr, Beverly Hills", pinTitle: "Hank Azaria"),
            
             Home(category:"Film & TV", name:"Walt Disney", URL: "https://en.wikipedia.org/wiki/Walt_Disney", pinLatitude: 34.084795 , pinLongitude : -118.429003, pinDetail : "355 Carolwood Drive, Beverly Hills", pinTitle: "Walt Disney (1901 - 1966)"),
            
            Home(category:"Iconic", name:"Modern Family Cam & Mitch", URL: "https://en.wikipedia.org/wiki/Modern_Family", pinLatitude: 34.051841 , pinLongitude : -118.416272, pinDetail : "2211 Fox Hills Dr, Beverly Hills", pinTitle: "Modern Family Cam & Mitch"),
            
            Home(category:"Iconic", name:"Modern Family Phil & Claire", URL: "https://en.wikipedia.org/wiki/Modern_Family", pinLatitude: 34.036356 , pinLongitude : -118.410230, pinDetail : "10336 Dunleer Dr, Beverly Hills", pinTitle: "Modern Family Phil & Claire"),
            
            Home(category:"Music", name:"John Fogerty", URL: "https://en.wikipedia.org/wiki/John_Fogerty", pinLatitude: 34.119185 , pinLongitude : -118.426535, pinDetail : "9754 Oak Pass Rd, Beverly Hills", pinTitle: "John Fogerty"),
            
            Home(category:"Film & TV", name:"Harrison Ford", URL: "https://en.wikipedia.org/wiki/Harrison_Ford", pinLatitude: 34.096974 , pinLongitude : -118.420953, pinDetail : "1420 Braeridge Drive, Beverly Hills", pinTitle: "Harrison Ford"),
            
            Home(category:"Music", name:"Madonna", URL: "https://en.wikipedia.org/wiki/Madonna_(entertainer)", pinLatitude: 34.0872054 , pinLongitude : -118.3994811, pinDetail : "9425 Sunset Blvd, Beverly Hills", pinTitle: "Madonna"),
            
            Home(category:"Film & TV", name:"Eddie Murphy", URL: "https://en.wikipedia.org/wiki/Eddie_Murphy", pinLatitude: 34.0991198 , pinLongitude : -118.3969917, pinDetail : "1081 Wallace Ridge, Beverly Hills", pinTitle: "Eddie Murphy"),
            
            //Elvis Presley
            Home(category:"Music", name:"Elvis Presley", URL: "https://en.wikipedia.org/wiki/Elvis_Presley", pinLatitude: 34.097919 , pinLongitude : -118.3969712, pinDetail : "Elvis lived here from November 1967 until sometime in 1970", pinTitle: "Elvis Presley (1935-1977)"),
        
        Home(category:"Other", name:"Markus Persson", URL: "https://en.wikipedia.org/wiki/Markus_Persson", pinLatitude: 34.097244, pinLongitude :  -118.394545 , pinDetail : "1181 N Hillcrest Rd, Beverly Hills", pinTitle: "Markus Persson"),
        
        Home(category:"Music", name:"Harry Styles", URL: "https://en.wikipedia.org/wiki/Harry_Styles", pinLatitude: 34.116593, pinLongitude : -118.426097 , pinDetail : "9551 Oak Pass Rd, Beverly Hills", pinTitle: "Harry Styles"),]
        
        
        
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