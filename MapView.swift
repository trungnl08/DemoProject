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
    let urlRequest = "https://storage.googleapis.com/mapsdevsite/json/quakes.geo.json"
    let handleApi = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var annotations = [MKPointAnnotation]()
        handleApi.requestApi(urlString: urlRequest) { res, err in
            guard let res = res else {return}
     
            for location in res {
                let annotation = MKPointAnnotation()
                guard let mag = location.mag else {return}
                guard let latitudeLoca = location.coordinates?[1] else {return}
                guard let longtitudeLoca =  location.coordinates?[0] else {return}
                annotation.title = "Mag:\(mag)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeLoca, longitude: longtitudeLoca)
                annotations.append(annotation)
            }
            let coordinate = CLLocationCoordinate2D(latitude: 50.5, longitude: -170)
            let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
            let region = MKCoordinateRegion(center: coordinate, span:span)
            self.mapview.setRegion(region, animated: true)
            let marker = MKPointAnnotation()
            marker.coordinate = coordinate
            marker.title = "first test"
            self.mapview.addAnnotation(marker)
            self.mapview.addAnnotations(annotations)

        }
        
      




        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //request policy + updatelocation
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
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
//        print("Run there")
//        if let location = locations.first {
//            manager.stopUpdatingLocation()
//            render(location)
//        }
//    }
//    func render(_ location: CLLocation){
//        let coordinate = CLLocationCoordinate2D(latitude: 50, longitude: -170)
//        print(location.coordinate)
//        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
//        let region = MKCoordinateRegion(center: coordinate, span:span)
//        mapview.setRegion(region, animated: true)
////        let marker = MKPointAnnotation()
////        marker.coordinate = coordinate
////        mapview.addAnnotation(marker)
//    }
    
}

