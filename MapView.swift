//
//  MapView.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()



        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
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
extension MapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span:span)
        mapview.setRegion(region, animated: true)
        let marker = MKPointAnnotation()
        marker.coordinate = coordinate
        mapview.addAnnotation(marker)
    }
    
}

//private extension MKMapView {
//  func centerToLocation(
//    _ location: CLLocation,
//    regionRadius: CLLocationDistance = 1000
//  ) {
//    let coordinateRegion = MKCoordinateRegion(
//      center: location.coordinate,
//      latitudinalMeters: regionRadius,
//      longitudinalMeters: regionRadius)
//    setRegion(coordinateRegion, animated: true)
//  }
//}
