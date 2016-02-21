//
//  DetailViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 5/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import iAd


class DetailViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate, ADBannerViewDelegate {
    
    // MARK: - Properties

    
    
    
    @IBOutlet var adBannerView: ADBannerView?
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var Controller: UISegmentedControl!
    @IBOutlet var MapView: MKMapView!

    var pageIndex: Int!
    var titleIndex: String!
    var imageFile: String!

    var pageViewController: UIPageViewController!
    var pageImages: NSArray!
    var pageTitles: NSArray!
    
    let locationManager = CLLocationManager()
    
    
    
    var detailHouse: Home? {
        didSet {
            configureView()
        }
    }
    
    func mapAnnotation() {
        //Taj Mahal Coordinates: 27.175015, 78.042139
        
         let detailH = detailHouse
        
        // Coordinates
        
        let annotationLat:CLLocationDegrees = detailH!.pinLatitude
        let annotationLong:CLLocationDegrees = detailH!.pinLongitude
        
        let annotationCo = CLLocationCoordinate2D(latitude: annotationLat, longitude: annotationLong)
        
        //Span
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        let annotationSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let Region = MKCoordinateRegion(center: annotationCo, span: annotationSpan)
        
        
        MapView.setRegion(Region, animated: true )
        
        let Annotation = MKPointAnnotation()
        Annotation.title = "\(detailH!.pinTitle)"
        Annotation.subtitle = "\(detailH!.pinDetail)"
        
        Annotation.coordinate = annotationCo
        
        MapView.addAnnotation(Annotation)
        
    }
    
    
    // CHANGE VIEW
    
    @IBAction func ChangeView(sender: AnyObject) {
        
        if Controller.selectedSegmentIndex == 0 {
            
            self.MapView.hidden = true
            self.webView.hidden = false
        }
        
        if Controller.selectedSegmentIndex == 1 {
         
            self.MapView.hidden = false
            self.webView.hidden = true
            
        }
        
    }
    func configureView() {
        if let detailH = detailHouse {
            if let detailDescriptionLabel = DescriptionLabel {
                detailDescriptionLabel.text = detailH.name
                }
            
                title = detailH.name
                
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        self.MapView.hidden = true
        self.webView.hidden = false
        
        var detailH = detailHouse
        
        if detailH?.URL == nil {
            
            detailH?.URL = "www.google.com"
            
        } else {
        
            
        if let url =  NSURL(string: detailH!.URL){
                
                let load = NSURLRequest(URL: url)
                webView.loadRequest(load)
            }
            
        }

        if detailH?.pinLongitude == nil {
        
            detailH?.pinLongitude = 0
            detailH?.pinLatitude = 0

        
        } else {
            
            configureView()
            mapAnnotation()
            
        }
        
    }
    
    @IBAction func ACtion(sender: AnyObject) {
        
        let detailH = detailHouse
        
        let mapItem = MKMapItem()
        
        mapItem.name = "\(detailH!.name)'s Home "
        
        //You could also choose: MKLaunchOptionsDirectionsModeWalking
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMapsWithLaunchOptions(launchOptions)
        
    }
    @IBAction func Directions(sender: AnyObject) {
        
        openMapForPlace()
        
    }
    
    func openMapForPlace() {
        
        let lat1 : Double = detailHouse!.pinLatitude
        let lng1 : Double = detailHouse!.pinLongitude
        
        let latitute:CLLocationDegrees =  lat1
        let longitute:CLLocationDegrees =  lng1
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span),
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(detailHouse!.name)"
        mapItem.openInMapsWithLaunchOptions(options)
        
        self.dismissViewControllerAnimated(true, completion: nil)

        
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


    
    
