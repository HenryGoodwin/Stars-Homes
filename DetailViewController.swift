//
//  DetailViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 5/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import iAd


class DetailViewController: UIViewController, ADBannerViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var adBannerView: ADBannerView?
    @IBOutlet weak var webView: UIWebView!

    
    var detailHouse: Home? {
        didSet {
            configureView()
        }
    }
    
    
    
    // CHANGE VIEW
    
        func configureView() {
            
            title = "Biography"
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        self.webView.hidden = false
        
        var detailH = detailHouse
        
        if detailH?.URL == nil {
            
            detailH?.URL = ""
            
        } else {
        
            
        if let url =  NSURL(string: detailH!.URL){
                
                let load = NSURLRequest(URL: url)
                webView.loadRequest(load)
            }
            
        }

            configureView()
        
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
        // Do any additional setup after loading the view, typically from a nib.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}


    
    
