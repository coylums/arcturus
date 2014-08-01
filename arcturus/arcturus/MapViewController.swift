//
//  mapViewController.swift
//  arcturus
//
//  Created by William Woolard on 7/29/14.
//  Copyright (c) 2014 coylums. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.mapView = MKMapView();

    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        var menuItem : UIImage = UIImage(named:"menu-icon")

        let menuBarButtonItem = UIBarButtonItem(image: menuItem, style: .Plain, target: self, action: nil)

        navigationItem.setLeftBarButtonItem(menuBarButtonItem, animated: false)
        
        self.mapView!.frame = self.parentViewController.view.bounds

        self.view.addSubview(self.mapView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        // TODO Create Web APi
        // TODO Display most recent point from Web API (defaulting to Oriental, NC for proof-of-concept)
        var location = CLLocationCoordinate2D(
            latitude: 35.0311,
            longitude: -76.6878
        )
        
        zoomToFitMapAnnotations(location)
        
    }
    
    func zoomToFitMapAnnotations(poi:CLLocationCoordinate2D) {
        
        var lat: Double = poi.latitude
        var lon: Double = poi.longitude
        
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,lon)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,800,800)
        
        self.mapView!.setRegion(region,animated:true)
        
        let customAnotation = MKPointAnnotation()
        
        customAnotation.coordinate = CLLocationCoordinate2D(latitude:lat , longitude: lon)
        customAnotation.title = "Oriental, NC"
        
        self.mapView!.addAnnotation(customAnotation)
        
    }
}