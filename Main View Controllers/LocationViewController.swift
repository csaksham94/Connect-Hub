//
//  NewViewController.swift
//  Connect Hub
//
//  Created by Saksham Chaudhary on 23/06/19.
//  Copyright © 2019 Saksham Chaudhary. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: BaseViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var goBtn: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters : Double = 10000
    var previousLocation : CLLocation?
    var directionsArray :   [MKDirections] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        goBtn.layer.cornerRadius = 50
        
    }
    
    func resetMapView(withNew directions: MKDirections) {
    
        mapView.removeOverlays(mapView!.overlays)
        
        directionsArray.append(directions)
         let _ = directionsArray.map {$0.cancel()}
       
     //   directionsArray.remove(directio)
 
        
    }
    
    
    func  getDirections(){
        
        guard let location = locationManager.location?.coordinate else {
            //lkmlkmkl
          return
        }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self](response, error) in
            guard let response = response else{return}

            for route in response.routes{
               // let steps = route.steps
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
        }
        
    }
    
    @IBAction func goBtnTapped(_ sender: Any) {
        getDirections()
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: destinationCoordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation )
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    func centerViewOnUserLocation(){
        
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
             mapView.setRegion(region, animated: true)
        }
        
        
    }
    func setUpLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            previousLocation = getCenterLocation(for: mapView)
            break
        case .denied:
            commonErrorfunction(title: "Permission Denied", msg: "Please go to settings-> App settings -> Allow Location Permission")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            commonErrorfunction(title: "Restricted..!", msg: "Location services restricted from OS.")
            break
        case .authorizedAlways:
            break
        
        }
    }
    
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
            
        }else{
            commonErrorfunction(title: "Location Services Disabled", msg: "Kindly turn device location ON..")
        }
    }

}

func getCenterLocation(for mapView : MKMapView) -> CLLocation{
    
    let lattitude = mapView.centerCoordinate.latitude
    let longitude = mapView.centerCoordinate.longitude
    
    return CLLocation(latitude: lattitude, longitude: longitude)
    
}


extension LocationViewController : CLLocationManagerDelegate {
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension LocationViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        
        
        guard let previousLocation = self.previousLocation else {return}
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks , error) in
            guard let self = self else {return}
            
            if let _ = error{
                return
            }
            
            guard let placemark = placemarks?.first else {return}
            let streetNumber = placemark.subLocality ?? ""
            let streetName = placemark.locality ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(String(describing: streetName)) \(String(describing: streetNumber))"
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .black
        return renderer
    }


}
