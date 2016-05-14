//
//  TBViewController.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 26/03/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class TBViewController: UITabBarController,MKMapViewDelegate, CLLocationManagerDelegate {
    
    
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


    var detailHouse: Home? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailH = detailHouse {
            
            title = detailH.name
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let direction = UIBarButtonItem(title: "Directions", style: .Plain, target: self, action: #selector(TBViewController.Directions))
        
        navigationItem.rightBarButtonItem = direction
        
        configureView()
        
        // Do any additional setup after loading the view.
    }
    
    func Directions() {
        openMapForPlace()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
