//
//  ShermanOaksTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 25/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class ShermanOaksTableViewController: UITableViewController, ADBannerViewDelegate {
    
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
        searchController.searchBar.placeholder = "Search For A Star"
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV", "Music", "Sport"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        House = [
            
           Home(category:"Film & TV", name:"Kaley Cuoco", URL: "https://en.wikipedia.org/wiki/Kaley_Cuoco", pinLatitude: 34.148293 , pinLongitude : -118.454634, pinDetail : "14717 Sutton St, Sherman Oaks", pinTitle: "Kaley Cuoco"),
            
        Home(category:"Music", name:"Brian Malouf", URL: "https://en.wikipedia.org/wiki/Brian_Malouf", pinLatitude: 34.161440 , pinLongitude : -118.421838 , pinDetail : "13245 Addison St, Sherman Oaks", pinTitle: "Brian Malouf"),
        
        Home(category:"Music", name:"Pink", URL: "https://en.wikipedia.org/wiki/Pink_(singer)", pinLatitude: 34.147459, pinLongitude : -118.455430 , pinDetail : "14734 Sutton St, Sherman Oaks", pinTitle: "Pink"),
        
        Home(category:"Sport", name:"Pete Rose", URL: "https://en.wikipedia.org/wiki/Pete_Rose", pinLatitude: 34.168034, pinLongitude :  -118.424271 , pinDetail : "13348 Chandler Blvd, Sherman Oaks", pinTitle: "Pete Rose"),]
        
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
    
    // showDetailShermanOaks
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailShermanOaks" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let house: Home
                if searchController.active && (searchController.searchBar.text != "" || !filteredHouse.isEmpty) {
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

extension ShermanOaksTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension ShermanOaksTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}