//
//  MalibuTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 24/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class MalibuTableViewController: UITableViewController, ADBannerViewDelegate {
    
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
            //Malibu
            //Bob Dylan
        Home(category:"Music", name:"Bob Dylan", URL: "https://en.wikipedia.org/wiki/Bob_Dylan", pinLatitude: 34.009805, pinLongitude : -118.811177, pinDetail : "29400 Bluewater Road, Malibu", pinTitle: "Bob Dylan"),
            
        Home(category:"Film & TV", name:"Yolanda Foster", URL: "https://en.wikipedia.org/wiki/Yolanda_Hadid", pinLatitude: 34.038773, pinLongitude : -118.650812, pinDetail : "3905 Carbon Canyon Rd, Malibu", pinTitle: "Yolanda Foster"),
            
        Home(category:"Film & TV", name:"Tom Hanks", URL: "https://en.wikipedia.org/wiki/Tom_Hanks", pinLatitude: 34.031287 , pinLongitude : -118.684904, pinDetail : "23414 Malibu Colony Dr, Malibu", pinTitle: "Tom Hanks"),
        
        Home(category:"Film & TV", name:"Chris Hemsworth", URL: "https://en.wikipedia.org/wiki/Chris_Hemsworth", pinLatitude: 34.010446, pinLongitude :  -118.803201 , pinDetail : "7022 Grasswood Ave, Malibu", pinTitle: "Chris Hemsworth"),
        
        Home(category:"Film & TV", name:"Howie Mandel", URL: "https://en.wikipedia.org/wiki/Howie_Mandel", pinLatitude: 34.011605, pinLongitude : -118.805946 , pinDetail : "6950 Dume Dr, Malibu", pinTitle: "Howie Mandel"),
            
        Home(category:"Music", name:"Chris Martin", URL: "https://en.wikipedia.org/wiki/Chris_Martin", pinLatitude: 34.011088 , pinLongitude : -118.795864 , pinDetail : "28815 Grayfox St, Malibu", pinTitle: "Chris Martin"),
        
        Home(category:"Film & TV", name:"Nick Nolte", URL: "https://en.wikipedia.org/wiki/Nick_Nolte", pinLatitude: 34.022249, pinLongitude : -118.814860 , pinDetail : "6173 Bonsall Dr, Malibu", pinTitle: "Nick Nolte"),
        
        Home(category:"Film & TV", name:"Gwyneth Paltrow", URL: "https://en.wikipedia.org/wiki/Gwyneth_Paltrow", pinLatitude: 34.011087 , pinLongitude :-118.795838, pinDetail : "28815 Grayfox St, Malibu", pinTitle: "Gwyneth Paltrow"),
        
        Home(category:"Film & TV", name:"Matthew Perry", URL: "https://en.wikipedia.org/wiki/Matthew_Perry", pinLatitude: 34.038513, pinLongitude : -118.676996 , pinDetail : "3556 Sweetwater Mesa Rd, Malibu", pinTitle: "Matthew Perry"),
        
        Home(category:"Music", name:"Kid Rock", URL: "https://en.wikipedia.org/wiki/Kid_Rock", pinLatitude: 34.009497, pinLongitude : -118.798325 , pinDetail : "28830 Bison Ct, Malibu", pinTitle: "Kid Rock"),
        
        Home(category:"Sport", name:"Chris Webber", URL: "https://en.wikipedia.org/wiki/Chris_Webber", pinLatitude: 34.044554, pinLongitude : -118.622946 , pinDetail : "20851 Big Rock Dr, Malibu", pinTitle: "Chris Webber"),
        ]
        
        
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
        if segue.identifier == "showDetailMalibu" {
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

extension MalibuTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension MalibuTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
