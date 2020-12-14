//
//  MapScreen.swift
//  findIt
//
//  Created by Victor Ung on 12/12/20.
//  Copyright © 2020 Eric Nguyen. All rights reserved.
//

import Parse
import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController, UISearchBarDelegate {

   
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var searches: UISearchBar!
    

    @IBAction func onSearch(_ sender: Any) {
        addAnnotations()
        searches.text = ""
    }
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var lastAnnotation: CLLocationCoordinate2D? = nil
    var entry: String = ""
    var loaded = 0
    var hasDetailsLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }

    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func centerViewOnLastAnnotation() {
        if let location = lastAnnotation {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func addPreexistingAnnotations() {
        if(loaded == 1){
            return
        }
        let query = PFQuery(className: "Locations")
        query.includeKeys(["Location"])
        query.limit = 20
               
        query.findObjectsInBackground() { (locations, error) in
            if locations != nil{
             if let prelocations = locations {
                for preexistinglocation in prelocations{
                    self.getCoordinates(city: preexistinglocation["Location"] as! String) { location in
                        guard let location = location else { return }
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        annotation.title = (preexistinglocation["Location"] as! String)
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
            }
        }
        loaded = 1
        self.centerViewOnUserLocation()
    }
    
    func addAnnotations() {
        let annotation = MKPointAnnotation()
        let city = searches.text!
        getCoordinates(city: city) { location in
            guard let location = location else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            annotation.title = city //"San Francisco"
            //annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7739, longitude: -122.4312)
            self.lastAnnotation = annotation.coordinate
            self.mapView.addAnnotation(annotation)
            self.centerViewOnLastAnnotation()
            
            let currLocation = PFObject(className: "Locations")
            currLocation["Location"] = city
            currLocation["hasDetails"] = false
            currLocation.saveInBackground() { (success, error) in
                       if success {
                           print("saved!")
                       } else {
                           print("error!")
                       }
                   }

        }
    }
    
    func getCoordinates(city name: String,
                        completion: @escaping(CLLocation?) -> Void) {
           
           let geocoder = CLGeocoder()
           geocoder.geocodeAddressString(name) { placemarks, error in
               
               guard error == nil else {
                   completion(nil)
                   return
               }
               
               guard let placemark = placemarks?[0] else {
                   completion(nil)
                   return
               }
               
               guard let location = placemark.location else {
                   completion(nil)
                   return
               }
               completion(location)
           }
       }
    
   
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if(self.hasDetailsLoaded == true){
                let detailsViewController = segue.destination as! LocationDetailsViewController
                detailsViewController.location = self.entry
            } else {
                let editViewController = segue.destination as! EditViewController
                editViewController.location = self.entry
            }
          
            
            
             
        }
        
    
    

}
extension MapScreen: MKMapViewDelegate {

   func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
    entry = view.annotation?.title as! String
    let query = PFQuery(className: "Locations")
    query.includeKeys(["Location"])
    query.limit = 20
    query.findObjectsInBackground() { (locations, error) in
        if locations != nil{
            if let prelocations = locations {
                for preexistinglocation in prelocations{
                    if(preexistinglocation["Location"] as! String == self.entry){
                        if(preexistinglocation["hasDetails"] as! Bool == true) {
                            self.hasDetailsLoaded = true
                            self.performSegue(withIdentifier: "LocationDetailsSegue", sender: nil)
                        }
                        else {
                            self.hasDetailsLoaded = false
                            self.performSegue(withIdentifier: "EditDetailsSegue", sender: nil)
                        }
                        
                    }
                }
            }
        }
    }
   }
}
    
extension MapScreen: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Be back
        guard let location = locationManager.location /*locations.last*/ else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        addPreexistingAnnotations()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

   

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


