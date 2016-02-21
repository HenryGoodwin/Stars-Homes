//
//  HollywoodHillsTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 25/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class HollywoodHillsTableViewController: UITableViewController, ADBannerViewDelegate {
    
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
            
        Home(category:"Film & TV", name:"Jason Bateman", URL: "https://en.wikipedia.org/wiki/Jason_Bateman", pinLatitude: 34.113902 , pinLongitude : -118.387308, pinDetail : "8828 Wonderland Park Ave, Hollywood Hills", pinTitle: "Jason Bateman"),
            
        Home(category:"Film & TV", name:"Jack Black", URL: "https://en.wikipedia.org/wiki/Jack_Black", pinLatitude: 34.117854 , pinLongitude :  -118.382431, pinDetail : "8538 Eastwood Rd, Hollywood Hills", pinTitle: "Jack Black"),
            
        Home(category:"Film & TV", name:"Kate Bosworth", URL: "https://en.wikipedia.org/wiki/Kate_Bosworth", pinLatitude: 34.118633 , pinLongitude :  -118.356116, pinDetail : "2633 La Cuesta Dr, Hollywood Hills", pinTitle: "Kate Bosworth"),
            
        Home(category:"Sport", name:"Reggie Bush", URL: "https://en.wikipedia.org/wiki/Reggie_Bush", pinLatitude: 34.098247 , pinLongitude : -118.382715, pinDetail : "1501 Viewsite Ter, Hollywood Hills", pinTitle: "Reggie Bush"),
            
         Home(category:"Music", name:"Dr. Dre", URL: "https://en.wikipedia.org/wiki/Dr._Dre", pinLatitude: 34.095974 , pinLongitude : -118.389796, pinDetail : "9161 Oriole Way, Hollwood Hills", pinTitle: "Dr. Dre"),
            
        Home(category:"Film & TV", name:"Zac Efron", URL: "https://en.wikipedia.org/wiki/Zac_Efron", pinLatitude: 34.122490 , pinLongitude : -118.367484, pinDetail : "7861 Woodrow Wilson Dr, Hollwood Hills", pinTitle: "Zac Efron"),
            
        Home(category:"Film & TV", name:"Megan Fox", URL: "https://en.wikipedia.org/wiki/Megan_Fox", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
            
        Home(category:"Film & TV", name:"Jeff Franklin", URL: "https://en.wikipedia.org/wiki/Jeff_Franklin", pinLatitude: 34.094353 , pinLongitude : -118.383226, pinDetail : "1302 Collingwood Place, Beverly Hills", pinTitle: "Jeff Franklin"),
            
        Home(category:"Film & TV", name:"Brian Austin Green", URL: "hhttps://en.wikipedia.org/wiki/Brian_Austin_Green", pinLatitude: 34.114836 , pinLongitude :  -118.296151, pinDetail : "2771 Glendower Ave, Los Feliz", pinTitle: "Brian Austin Green & Megan Fox’s House"),
            
        Home(category:"Film & TV", name:"Jake Gyllenhaal", URL: "https://en.wikipedia.org/wiki/Jake_Gyllenhaal", pinLatitude: 34.124929, pinLongitude :  -118.355291, pinDetail : "17411 Woodrow Wilson Dr, Hollywood Hills", pinTitle: "Jake Gyllenhaal"),
            
        Home(category:"Music", name:"John Legend",URL: "https://en.wikipedia.org/wiki/John_Legend", pinLatitude: 34.124322 , pinLongitude : -118.339005, pinDetail : "3023 Longdale Ln, Hollywood Hills", pinTitle: "John Legend"),
            
        Home(category:"Film & TV", name:"Justin Long",URL: "https://en.wikipedia.org/wiki/Justin_Long", pinLatitude: 34.110926 , pinLongitude :  -118.313095, pinDetail : "5682 Holly Oak Dr, Hollywood Hills", pinTitle: "Justin Long"),
            
        Home(category:"Film & TV", name:"Christopher Meloni", URL: "https://en.wikipedia.org/wiki/Christopher_Meloni", pinLatitude: 34.104265 , pinLongitude : -118.349960 , pinDetail : "1822 Camino Palmero St, Hollywood Hills", pinTitle: "Christopher Meloni"),
            
        Home(category:"Film & TV", name:"Eva Mendes", URL: "https://en.wikipedia.org/wiki/Eva_Mendes", pinLatitude: 34.116675 , pinLongitude : -118.318562 , pinDetail : "2732 Hollyridge Dr, Hollywood Hills", pinTitle: "Eva Mendes"),
        
        Home(category:"Other", name:"Jack Osbourne", URL: "https://en.wikipedia.org/wiki/Jack_Osbourne", pinLatitude: 34.111421, pinLongitude : -118.294152 , pinDetail : "2220 N Berendo St, Los Feliz", pinTitle: "Jack Osbourne"),
        
        Home(category:"Music", name:"Kelly Osbourne", URL: "https://en.wikipedia.org/wiki/Kelly_Osbourne", pinLatitude: 34.099357, pinLongitude : -118.369727 , pinDetail : "8281 Hollywood Blvd, Hollywood Hills", pinTitle: "Kelly Osbourne"),
        
        Home(category:"Film & TV", name:"Mario Van Peebles", URL: "https://en.wikipedia.org/wiki/Mario_Van_Peebles", pinLatitude: 34.124877, pinLongitude : -118.351144 , pinDetail : "3094 Ellington Dr, Hollywood Hills", pinTitle: "Mario Van Peebles"),
        
        Home(category:"Film & TV", name:"Jeremy Renner", URL: "https://en.wikipedia.org/wiki/Jeremy_Renner", pinLatitude: 34.103100, pinLongitude :  -118.351675 , pinDetail : "7420 Franklin Ave, Hollywood Hills", pinTitle: "Jeremy Renner"),
        
        Home(category:"Film & TV", name:"Meryl Streep", URL: "https://en.wikipedia.org/wiki/Meryl_Streep", pinLatitude: 34.099142, pinLongitude :  -118.383923 , pinDetail : "1514 Rising Glen Rd, Hollywood Hills", pinTitle: "Meryl Streep"),]
        
        
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
        if segue.identifier == "showDetailHW" {
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

extension HollywoodHillsTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension HollywoodHillsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
}
}
