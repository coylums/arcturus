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

    var logEntries: Array<LogEntry>!

    var annotations = [MKPointAnnotation]()
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.mapView = MKMapView();

        self.logEntries = Array<LogEntry>()

        self.title = "Arcturus"

    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        var menuItem : UIImage = UIImage(named:"menu-icon")

        let menuBarButtonItem = UIBarButtonItem(image: menuItem, style: .Plain, target: self, action: nil)

        navigationItem.setLeftBarButtonItem(menuBarButtonItem, animated: false)
        
        self.mapView!.frame = self.parentViewController.view.bounds

        self.mapView!.delegate = self

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

        self.logEntries = LogFileDataService.getLogBookEntries()

        self.prepareAnnotations()
        
        zoomToFitMapAnnotations()
        
    }

    func zoomToFitMapAnnotations() {

        //Fit annotations on within the view.
        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)

        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)

        for annotation in self.annotations {

            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);

            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        }

        var centerLatitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        var centerLongitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5

        var center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)

        var latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.3; // Add a little extra space on the sides
        var longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.3; // Add a little extra space on the sides

        var span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)

        // Create region
        var region = MKCoordinateRegion(center: center, span: span)
        
        var mapRegion = self.mapView.regionThatFits(region)
        
        self.mapView.setRegion(mapRegion, animated: true)

        self.mapView.addAnnotations(self.annotations)

    }

    func prepareAnnotations() {

        self.annotations = []

        for logEntry in self.logEntries  {

            var newAnnotation = MKPointAnnotation()

            newAnnotation.coordinate.latitude = logEntry.latitude
            newAnnotation.coordinate.longitude = logEntry.longitude

            newAnnotation.title = "At Helm: \(logEntry.personAtHelm)"

            newAnnotation.subtitle = "Sky: \(logEntry.sky)\nTemp: \(logEntry.temp)\nComments: \(logEntry.comments)"

            self.annotations.append(newAnnotation)

        }

    }

//    func prepareLogEntryAnnotationPath() {
//
//        var mapPoints = [MKMapPoint]()
//
//        for annotation in self.annotations {
//
//            var mapPoint: MKMapPoint = MKMapPointMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
//
//            mapPoints.append(mapPoint)
//
//        }
//
//        var polyline = MKPolyline(coordinates: <#UnsafePointer<CLLocationCoordinate2D>#>, count: <#Int#>)
//
//    }

//    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
//
//
//
//    }

}