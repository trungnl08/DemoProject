//
//  MapView2Controller.swift
//  DemoProject
//
//  Created by Frog Pepe on 28/06/2022.
//

import UIKit
import MapKit

class MapView2Controller: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    
   private let manager = CLLocationManager()
  private var currentLocation: CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapview.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        configureLocationService()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    private func configureLocationService(){
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
      beginLocationUpdate(locationManager: manager)
    }

    private func beginLocationUpdate(locationManager: CLLocationManager){
        mapview.showsUserLocation = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    private func zoomToLastestLocation(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapview.setRegion(region, animated: true)
        
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

extension MapView2Controller: CLLocationManagerDelegate, MKMapViewDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
//        if let location = locations.first {
//            manager.stopUpdatingLocation()
//            render(location)
//        }
//    }
//
//    func render(_ location: CLLocation){
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude ,longitude: location.coordinate.longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: coordinate, span:span)
//        mapview.setRegion(region, animated: true)
//        print(coordinate)
//        let marker = CustomAnnotation()
//        marker.pinCustomImage = marker.resizeImage(image: UIImage(named: "car"), targetSize: CGSize(width: 40, height: 40))
//        marker.coordinate = coordinate
//        mapview.addAnnotation(marker)
//        let marker2 = MKPointAnnotation()
//        marker2.title = "Target"
//        marker2.coordinate = CLLocationCoordinate2D(latitude: 38, longitude: -122)
//        mapview.addAnnotation(marker2)
//    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get lastest location!!!!!!!")
        guard let lastestLocation = locations.first else { return}
        if currentLocation == nil {
            zoomToLastestLocation(with: lastestLocation.coordinate)
        }
        currentLocation = lastestLocation.coordinate
    }
    
}
