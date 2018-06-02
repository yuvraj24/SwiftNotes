//
//  LocationViewController.swift
//  SwiftStorage
//
//  Created by new on 29/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: BaseViewController, CLLocationManagerDelegate , MKMapViewDelegate, UISearchBarDelegate{
    
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var searchView: UISearchBar!
    var controller : NotesViewController? = nil
    var coordinates : CLLocationCoordinate2D? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        searchView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            print("Permission granted to use app when in use")
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            print("Permission granted to use app when in use")
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.debugDescription)
        if let locatn = locations.first{
            print("Location : "+locatn.description+"")
            let region = MKCoordinateRegionMakeWithDistance(locatn.coordinate, 100, 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func addAnnotation(location : CLLocation){
        annotation.coordinate = location.coordinate
        annotation.title = "Mumbai"
        annotation.subtitle = "A City of Fame"
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView.init(annotation: self.annotation, reuseIdentifier: "pin")
        view.image = UIImage(named: "marker.png")
        let transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        view.transform = transform
        return view
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Clicked")
        
        // Block User Interaction
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Show Activity Indicator
        showProgressIndicator()
        
        // Dismiss Keyboard
        searchBar.resignFirstResponder()
        
        // Search Request
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        
        let response = MKLocalSearch(request: request)
        response.start { (result, error) in
            if(result != nil){
                
                UIApplication.shared.endIgnoringInteractionEvents()
                self.hideProgressIndicator()
                
                //Remove already rendered Annotations
                let annotation = self.mapView.annotations
                self.mapView.removeAnnotations(annotation)
                
                // Get lat & long from response
                let lattitude = result?.boundingRegion.center.latitude
                let longitude = result?.boundingRegion.center.longitude
                
                let newAnnotation = MKPointAnnotation();
                newAnnotation.title = searchBar.text
                
                self.coordinates = CLLocationCoordinate2DMake(lattitude!, longitude!)
                newAnnotation.coordinate = self.coordinates!
                self.mapView.addAnnotation(newAnnotation)
                
                let region = MKCoordinateRegionMakeWithDistance(self.coordinates!, 10, 10)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        
        if searchView.text != "" && coordinates != nil {
            let helper = LocationHelper(location: self.searchView.text!, lat: (coordinates?.latitude)!, long: (coordinates?.longitude)!)
            self.controller?.setLocationParams(helper: helper)
            self.navigationController?.popViewController(animated: true)
        }
    } 
    
}
