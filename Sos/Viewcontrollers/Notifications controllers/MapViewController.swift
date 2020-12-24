//
//  MapViewController.swift
//  Sos
//
//  Created by hussein awaesha on 12/24/20.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase
class MapViewController: UIViewController,CLLocationManagerDelegate {

    lazy var manager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database(url: "https://sosapp-7a8db-default-rtdb.firebaseio.com/").reference().child("User")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
            ref.child("Location").setValue(["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude])
        }
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "user_location"
        pin.subtitle = "current_userLocation"
        mapView.addAnnotation(pin)
        mapView.showsCompass = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
