//
//  SecondDetailViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 26/03/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import iAd


class SecondDetailViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate, ADBannerViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var adBannerView: ADBannerView?
    @IBOutlet var MapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    
    
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
    
    
    var detailHouse: Home? {
        didSet {
            configureView()
        }
    }
    
    
    
    // CHANGE VIEW
    
    func configureView() {
        
        
        title = "Map"
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.MapView.showsUserLocation = true

        
        var detailH = detailHouse
        
        if detailH?.pinLongitude == nil {
            
            detailH?.pinLongitude = 0
            detailH?.pinLatitude = 0
            
            
        } else {
            
            configureView()
            mapAnnotation()
            
        }
        
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
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




