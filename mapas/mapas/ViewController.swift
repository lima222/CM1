//
//  ViewController.swift
//  mapas
//
//  Created by DocAdmin on 5/2/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var locationManager: CLLocationManager = CLLocationManager()
    var coordinateInMap: CLLocation!
    var latestLocation: CLLocation!
    var somePoints = [CLLocationCoordinate2D]()

    @IBOutlet var mapView: MKMapView!
    var geocoder = CLGeocoder()
    @IBOutlet var labelGeo: UILabel!
    @IBOutlet var textGeo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 41.701497, longitude: -8.834756)
        centerMapOnLocation(location: initialLocation)
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        let longPressedRecognized = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        mapView.addGestureRecognizer(tapGesture)
        mapView.addGestureRecognizer(longPressedRecognized)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = locations[locations.count - 1]
        
        var result = "Latitude: " + String(format: "%.4f", latestLocation.coordinate.latitude)
        result = result + "Longitude: " + String(format: "%.4f", latestLocation.coordinate.longitude)
        
        labelGeo.text = result
        
        result = result + " Accu: " + String(format: "%.4f", latestLocation.horizontalAccuracy)
        print(result)
    }
    
    
    
    @IBAction func ondeEstou(_ sender: Any) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func butDistancia(_ sender: Any) {
        print(coordinateInMap)
        print(latestLocation)
        let distanceBetween: CLLocationDistance = latestLocation.distance(from: coordinateInMap)
        labelGeo.text = String(format: "%.2f", distanceBetween) + " metros"
    }
    
    @IBAction func butGeocoding(_ sender: Any) {
        geocoder.geocodeAddressString(textGeo.text!) {
            (placemarks, error) in self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks :[CLPlacemark]?, error: Error? ){
        
        if let error = error {
            print("aaa")
            labelGeo.text = "Nao foi possivel encontrar a morada"
            
        } else {
            var location :CLLocation?
            if let placemarks = placemarks, placemarks.count>0{
                location = placemarks.first?.location
            }
            if let location = location{
                let coordinate = location.coordinate
                labelGeo.text="\(coordinate.latitude),\(coordinate.longitude)"
                centerMapOnLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
                coordinateInMap = CLLocation(latitude: coordinate.longitude, longitude: coordinate.longitude)
                
                
            } else {
                labelGeo.text = "nao foi possivel encontrar o endereco"
            }
        }
    }
    
    private func processResponceRev(withPlacemarks placemarks : [CLPlacemark]?, error: Error?){
        
        if let error = error {
            print("Unable to Reverse geocoding  Location(\(error))")
            labelGeo.text="unable to find  address for location"
            
            
        } else {
            if let placemarks  = placemarks, let placemark = placemarks.first{
                
                labelGeo.text = "\(placemark.country!) - \(placemark.locality!)  - \(placemark.postalCode!) - \(placemark.name!)"
            }
            else {
                labelGeo.text = "no matching adress founfing"
            }
            
        }
        
        
        
    }
    
    func tapped(_ sender:UITapGestureRecognizer){
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        let newCoord: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
        
        somePoints.append(newCoord)
        if(somePoints.count == 4) {
            addBoundry()
        }
    }
    
    func addBoundry() {
        let polygon = MKPolygon(coordinates: &somePoints, count: somePoints.count)
        mapView.add(polygon)
    }
    
    func longPressed(_ sender: UILongPressGestureRecognizer){
        
        if sender.state.rawValue == 1{
            print("long tap")
             let touchLocation = sender.location(in: mapView)
             let locationCoordinate  = mapView.convert(touchLocation, toCoordinateFrom: mapView)
             print("Long Tapped at lat:\(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
             
             // geocode location
             geocoder.reverseGeocodeLocation(location) {  (placemarks, error) in
         
             self.processResponceRev(withPlacemarks: placemarks, error: error)
             
             }
            
            calculateRota(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            
        }
    }
    
    func calculateRota(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude), addressDictionary: nil))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            if error != nil {
                print("error getting information" + error.debugDescription)
            } else {
                self.showRoute(response!)
            }
        })
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        
        for route in response.routes {
            mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            for step in route.steps {
                print(step.instructions)
            }
                
        }
    }
        
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        point.title = "Santa Luzia"
        point.subtitle = "Viana do Castelo"
        mapView.addAnnotation(point)
        
        mapView.add(MKCircle(center: point.coordinate, radius: 200))
        
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.lightGray
            return circleRenderer
        }
        
        if overlay is MKPolygon {
            let polygnonView = MKPolygonRenderer(overlay: overlay)
            polygnonView.strokeColor = UIColor.magenta
            return polygnonView
        }
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
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

