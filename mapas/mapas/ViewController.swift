//
//  ViewController.swift
//  mapas
//
//  Created by DocAdmin on 5/2/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 41.701497, longitude: -8.834756)
        centerMapOnLocation(location: initialLocation)
        
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 41.701497, longitude: -8.834756)
        point.title = "Santa Luzia"
        point.subtitle = "Viana do Castelo"
        mapView.addAnnotation(point)
        
    }
    @IBAction func clickSegControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            break;
            
        case 1:
            mapView.mapType = .satellite
            break;
            
        default:
            mapView.mapType = .hybrid
        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control : UIControl ) {
        if control == view.rightCalloutAccessoryView{
            print(view.annotation!.title!!)
            print(view.annotation!.subtitle!!)
            print(view.annotation!.coordinate)
            
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId =  "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        
        
        
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
        }
        let button  = UIButton(type: .detailDisclosure) as UIButton
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

