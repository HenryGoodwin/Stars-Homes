//
//  LosOlivosTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 24/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class LosOlivosTableViewController: UITableViewController, ADBannerViewDelegate {
    
    
    @IBOutlet var longPressView: UITableViewCell!
    
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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search For A Star"
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Music"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        House = [
            Home(category:"Music", name:"Michael Jackson's Neverland Ranch", URL: "https://en.wikipedia.org/wiki/Neverland_Ranch", pinLatitude: 34.741603 , pinLongitude :  -120.092954, pinDetail : "5225 Figueroa Mountain Rd, Los Olivos", pinTitle: "Michael Jackson's Neverland Ranch")]
    }
    
    deinit{
        if let superView = searchController.view.superview
        {
            superView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
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
        if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty) {
            return filteredHouse.count
        }
        return House.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let house: Home
        
        
        if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty) {
            
            house = filteredHouse[indexPath.row]
        } else {
            house = House[indexPath.row]
        }
        cell.textLabel!.text = house.name
        cell.detailTextLabel!.text = house.category
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredHouse = House.filter({ house -> Bool in
            let categoryMatch = (scope == "All") || (house.category == scope)
            if searchText.isEmpty {
                return categoryMatch
            } else {
                return categoryMatch && house.name.lowercaseString.containsString(searchText.lowercaseString)
            }
        })
        tableView.reloadData()
    }
    
    // MARK: - Segues
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailLosOlivos" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let house: Home
                if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty){
                    house = filteredHouse[indexPath.row]
                } else {
                    house = House[indexPath.row]
                }
                
                let tabBar = segue.destinationViewController as? TBViewController
                let controller = tabBar?.viewControllers![0] as! DetailViewController
                let secondController = tabBar?.viewControllers![1] as! SecondDetailViewController
                
                controller.detailHouse = house
                secondController.detailHouse = house
                tabBar?.detailHouse = house
                secondController.navigationItem.leftItemsSupplementBackButton = true
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





extension LosOlivosTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension LosOlivosTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
