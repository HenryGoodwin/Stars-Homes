//
//  OptionsTableViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 20/02/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd

class OptionsTableViewController: UITableViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView: ADBannerView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.adBannerView?.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.adBannerView?.hidden = true
    }


    // MARK: - Table view data source

    
}
