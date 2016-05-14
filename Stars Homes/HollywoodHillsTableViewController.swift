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
        searchController.searchBar.placeholder = "Search For A Star"
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Film & TV", "Music", "Sport"]
        tableView.tableHeaderView = searchController.searchBar
        
        
        House = [
            
        Home(category:"Film & TV", name:"Jason Bateman", URL: "https://en.wikipedia.org/wiki/Jason_Bateman", pinLatitude: 34.113902 , pinLongitude : -118.387308, pinDetail : "8828 Wonderland Park Ave, Hollywood Hills", pinTitle: "Jason Bateman"),
            
        Home(category:"Film & TV", name:"Jack Black", URL: "https://en.wikipedia.org/wiki/Jack_Black", pinLatitude: 34.117854 , pinLongitude :  -118.382431, pinDetail : "8538 Eastwood Rd, Hollywood Hills", pinTitle: "Jack Black"),
        
        Home(category:"Film & TV", name:"Orlando Bloom", URL: "https://en.wikipedia.org/wiki/Orlando_Bloom", pinLatitude: 34.116248, pinLongitude :  -118.348198 , pinDetail : "2645 Outpost Dr, Hollywood Hills", pinTitle: "Orlando Bloom"),
            
        Home(category:"Film & TV", name:"Kate Bosworth", URL: "https://en.wikipedia.org/wiki/Kate_Bosworth", pinLatitude: 34.118633 , pinLongitude :  -118.356116, pinDetail : "2633 La Cuesta Dr, Hollywood Hills", pinTitle: "Kate Bosworth"),
            
        Home(category:"Sport", name:"Reggie Bush", URL: "https://en.wikipedia.org/wiki/Reggie_Bush", pinLatitude: 34.098247 , pinLongitude : -118.382715, pinDetail : "1501 Viewsite Ter, Hollywood Hills", pinTitle: "Reggie Bush"),
            
         Home(category:"Music", name:"Dr. Dre", URL: "https://en.wikipedia.org/wiki/Dr._Dre", pinLatitude: 34.095974 , pinLongitude : -118.389796, pinDetail : "9161 Oriole Way, Hollwood Hills", pinTitle: "Dr. Dre"),
            
        Home(category:"Film & TV", name:"Zac Efron", URL: "https://en.wikipedia.org/wiki/Zac_Efron", pinLatitude: 34.122490 , pinLongitude : -118.367484, pinDetail : "7861 Woodrow Wilson Dr, Hollwood Hills", pinTitle: "Zac Efron"),
        
        Home(category:"Film & TV", name:"Craig Ferguson", URL: "https://en.wikipedia.org/wiki/Craig_Ferguson", pinLatitude: 34.113177, pinLongitude : -118.323612 , pinDetail : "6248 Winans Dr, Hollywood Hills", pinTitle: "Craig Ferguson"),
        
            
        Home(category:"Film & TV", name:"Jodie Foster", URL: "https://en.wikipedia.org/wiki/Jodie_Foster", pinLatitude: 34.097658, pinLongitude : -118.391320 , pinDetail : " 9219 Flicker Way, Hollywood Hills", pinTitle: "Jodie Foster"),
            
        Home(category:"Film & TV", name:"Jeff Franklin", URL: "https://en.wikipedia.org/wiki/Jeff_Franklin", pinLatitude: 34.094353 , pinLongitude : -118.383226, pinDetail : "1302 Collingwood Place, Hollywood Hills", pinTitle: "Jeff Franklin"),
            
        Home(category:"Film & TV", name:"Jake Gyllenhaal", URL: "https://en.wikipedia.org/wiki/Jake_Gyllenhaal", pinLatitude: 34.124929, pinLongitude :  -118.355291, pinDetail : "17411 Woodrow Wilson Dr, Hollywood Hills", pinTitle: "Jake Gyllenhaal"),
            
        Home(category:"Film & TV", name:"Michael C. Hall", URL: "https://en.wikipedia.org/wiki/Michael_C._Hall", pinLatitude: 34.108934, pinLongitude : -118.327782 , pinDetail : "2092 Mound St, Hollywood Hills", pinTitle: "Michael C. Hall"),
            
        Home(category:"Film & TV", name:"Joshua Jackson", URL: "https://en.wikipedia.org/wiki/Joshua_Jackson", pinLatitude: 34.111456, pinLongitude :  -118.327681 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Joshua Jackson"),
            
        Home(category:"Film & TV", name:"Chris Kattan", URL: "https://en.wikipedia.org/wiki/Chris_Kattan", pinLatitude: 34.103090, pinLongitude : -118.357158 , pinDetail : "1746 Courtney Ave, Hollwood Hills", pinTitle: "Chris Kattan"),
            
            
        Home(category:"Film & TV", name:"Diane Kruger", URL: "https://en.wikipedia.org/wiki/Diane_Kruger", pinLatitude: 34.111456, pinLongitude :  -118.327681 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Diane Kruger"),
            
        Home(category:"Music", name:"John Legend",URL: "https://en.wikipedia.org/wiki/John_Legend", pinLatitude: 34.124322 , pinLongitude : -118.339005, pinDetail : "3023 Longdale Ln, Hollywood Hills", pinTitle: "John Legend"),
            
        Home(category:"Film & TV", name:"Justin Long",URL: "https://en.wikipedia.org/wiki/Justin_Long", pinLatitude: 34.110926 , pinLongitude :  -118.313095, pinDetail : "5682 Holly Oak Dr, Hollywood Hills", pinTitle: "Justin Long"),
            
        Home(category:"Film & TV", name:"Christopher Meloni", URL: "https://en.wikipedia.org/wiki/Christopher_Meloni", pinLatitude: 34.104265 , pinLongitude : -118.349960 , pinDetail : "1822 Camino Palmero St, Hollywood Hills", pinTitle: "Christopher Meloni"),
            
        Home(category:"Film & TV", name:"Eva Mendes", URL: "https://en.wikipedia.org/wiki/Eva_Mendes", pinLatitude: 34.116675 , pinLongitude : -118.318562 , pinDetail : "2732 Hollyridge Dr, Hollywood Hills", pinTitle: "Eva Mendes"),
        
        Home(category:"Music", name:"Kelly Osbourne", URL: "https://en.wikipedia.org/wiki/Kelly_Osbourne", pinLatitude: 34.099357, pinLongitude : -118.369727 , pinDetail : "8281 Hollywood Blvd, Hollywood Hills", pinTitle: "Kelly Osbourne"),
            
        Home(category:"Film & TV", name:"Robert Pattinson", URL: "https://en.wikipedia.org/wiki/Robert_Pattinson", pinLatitude: 34.111464, pinLongitude : -118.327691 , pinDetail : "6342 Ivarene Ave, Hollywood Hills", pinTitle: "Robert Pattinson"),
        
        Home(category:"Film & TV", name:"Mario Van Peebles", URL: "https://en.wikipedia.org/wiki/Mario_Van_Peebles", pinLatitude: 34.124877, pinLongitude : -118.351144 , pinDetail : "3094 Ellington Dr, Hollywood Hills", pinTitle: "Mario Van Peebles"),
            
        Home(category:"Music", name:"Katy Perry", URL: "https://en.wikipedia.org/wiki/Katy_Perry", pinLatitude: 34.100882, pinLongitude : -118.366233 , pinDetail : "8159 Hollywood Blvd, Hollywood Hills", pinTitle: "Katy Perry"),
            
            
        Home(category:"Film & TV", name:"Christina Ricci", URL: "https://en.wikipedia.org/wiki/Christina_Ricci", pinLatitude: 34.112467, pinLongitude : -118.308437 , pinDetail : "5417 Red Oak Dr, Hollywood Hills", pinTitle: "Christina Ricci"),
        
        Home(category:"Film & TV", name:"Jeremy Renner", URL: "https://en.wikipedia.org/wiki/Jeremy_Renner", pinLatitude: 34.103100, pinLongitude :  -118.351675 , pinDetail : "7420 Franklin Ave, Hollywood Hills", pinTitle: "Jeremy Renner"),
            
        Home(category:"Film & TV", name:"Ryan Reynolds", URL: "https://en.wikipedia.org/wiki/Ryan_Reynolds", pinLatitude: 34.114687, pinLongitude : -118.345763 , pinDetail : " 2416 Carman Crest Dr, Hollywood Hills", pinTitle: "Ryan Reynolds"),
        
        Home(category:"Film & TV", name:"Meryl Streep", URL: "https://en.wikipedia.org/wiki/Meryl_Streep", pinLatitude: 34.099142, pinLongitude :  -118.383923 , pinDetail : "1514 Rising Glen Rd, Hollywood Hills", pinTitle: "Meryl Streep"),
            
        Home(category:"Sport", name:"Ian Thorpe", URL: "https://en.wikipedia.org/wiki/Ian_Thorpe", pinLatitude: 34.103446, pinLongitude : -118.376989 , pinDetail : "8522 Oak Ct, Hollywood Hills", pinTitle: "Ian Thorpe"),
        
        Home(category:"Sport", name:"Venus Williams", URL: "https://en.wikipedia.org/wiki/Venus_Williams", pinLatitude: 34.116546, pinLongitude : -118.356811 , pinDetail : "2521 Astral Dr, Hollywood Hills", pinTitle: "Venus Williams"),
        
        Home(category:"Film & TV", name:"Constance Zimmer", URL: "https://en.wikipedia.org/wiki/Constance_Zimmer", pinLatitude: 34.108610, pinLongitude : -118.314193 , pinDetail : "5715 Briarcliff Rd ,Hollywood Hills", pinTitle: "Constance Zimmer"),]
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
    
    // showDetailHW
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailHW" {
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
