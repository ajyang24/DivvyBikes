//
//  DetailViewController.swift
//  Divvy Bikes
//
//  Created by Andrew Yang on 6/26/17.
//  Copyright © 2017 Andrew Yang. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
    
    
    var detailItem:[String:String]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        coordinate = CLLocationCoordinate2DMake(Double(detailItem["latitude"]!)!, Double(detailItem["longitude"]!)!)
        
        
        myTextView.text = "Station name: " + detailItem["stationName"]! + "\n" + "\n" + "Available bikes: " + detailItem["availableBikes"]! + "\n" + "\n" + "Available docks: " + detailItem["availableDocks"]! + "\n" + "\n" + "Total docks: " + detailItem["totalDocks"]!
        
        locationManager.delegate = self
        myMapView.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        setCenterOfMapToLocation(location: coordinate)
        addPinAnnotationToMapView(location: coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locationManager.location)
    }

    func setCenterOfMapToLocation (location: CLLocationCoordinate2D)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: location, span: span)
        myMapView.setRegion(region, animated: true)
    }
    
    func addPinAnnotationToMapView(location: CLLocationCoordinate2D)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        myMapView.addAnnotation(annotation)
    }



}
