//
//  LosFelizTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 26/02/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class LosFelizTableViewController: UITableViewController, ADBannerViewDelegate {
    
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
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV","Other"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        House = [
            
            Home(category:"Film & TV", name:"Jesse Tyler Ferguson", URL: "https://en.wikipedia.org/wiki/Jesse_Tyler_Ferguson", pinLatitude: 34.117374, pinLongitude : -118.288129 , pinDetail : "2566 Aberdeen Ave, Los Feliz", pinTitle: "Jesse Tyler Ferguson"),
            
             Home(category:"Film & TV", name:"Megan Fox", URL: "https://en.wikipedia.org/wiki/Megan_Fox", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
        
            Home(category:"Film & TV", name:"Brian Austin Green", URL: "hhttps://en.wikipedia.org/wiki/Brian_Austin_Green", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
        
            Home(category:"Other", name:"Jamie Kennedy", URL: "https://en.wikipedia.org/wiki/Jamie_Kennedy", pinLatitude: 34.115899, pinLongitude :  -118.289968 , pinDetail : "2508 N Vermont Ave, Los Feliz", pinTitle: "Jamie Kennedy"),
        
            Home(category:"Other", name:"Jack Osbourne", URL: "https://en.wikipedia.org/wiki/Jack_Osbourne", pinLatitude: 34.111421, pinLongitude : -118.294152 , pinDetail : "2220 N Berendo St, Los Feliz", pinTitle: "Jack Osbourne"),
        
            Home(category:"Film & TV", name:"Zoe Saldana", URL: "https://en.wikipedia.org/wiki/Zoe_Saldana", pinLatitude: 34.105964, pinLongitude : -118.278210 , pinDetail : "2320 St George St, Los Feliz", pinTitle: "Zoe Saldana"),]
        
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
        if segue.identifier == "showDetailLosFeliz" {
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

extension LosFelizTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension LosFelizTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}