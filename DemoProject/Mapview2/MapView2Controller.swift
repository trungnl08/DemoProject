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
    private var destications: [MKPointAnnotation] = []
    private var currentRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
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
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapview.setRegion(region, animated: true)
        
    }
    
    private func addAnnotation(){
        let parkAnnotation = MKPointAnnotation()
        parkAnnotation.title = "Park test"
        parkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.3333666, longitude: -122.03076342)
        
        let secondParkAnnotation = MKPointAnnotation()
        secondParkAnnotation.title = "Park test"
        secondParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.33226, longitude: -122.025617)
        
        destications.append(parkAnnotation)
        destications.append(secondParkAnnotation)
        
        mapview.addAnnotations(destications)
    }
    private func constructRoute(userLocation: CLLocationCoordinate2D){
        let directionsRequest = MKDirections.Request()
        
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination =  MKMapItem(placemark: MKPlacemark(coordinate: destications[0].coordinate))
        directionsRequest.requestsAlternateRoutes = true
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate {
          [weak self]  (directionsResponse, error) in
            guard let strongSelf = self else {return}
            if let error = error {
                print("error there")
                print(error.localizedDescription)
            } else if let response = directionsResponse, response.routes.count > 0 {
                strongSelf.currentRoute = response.routes[0]
                strongSelf.mapview.addOverlay(response.routes[0].polyline)
                strongSelf.mapview.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage! {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

extension MapView2Controller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get lastest location!!!!!!!")
        guard let lastestLocation = locations.first else { return}
        if currentLocation == nil {
            zoomToLastestLocation(with: lastestLocation.coordinate)
            addAnnotation()
            constructRoute(userLocation: lastestLocation.coordinate)
        }
        
        currentLocation = lastestLocation.coordinate
    }
    
}
extension MapView2Controller: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if(annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if annotation.title == "Park test" {
            annotationView?.image = resizeImage(image: UIImage(named: "park")!, targetSize: CGSize(width: 30, height: 30))
        } else if annotation === mapview.userLocation {
            annotationView?.image = resizeImage(image: UIImage(named: "car")!, targetSize: CGSize(width: 30, height: 30))
        }
        annotationView?.canShowCallout = true
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let currentRoute = currentRoute else {
            return MKOverlayRenderer()
        }
        let polylineRender = MKPolylineRenderer(polyline: currentRoute.polyline)
        polylineRender.strokeColor = UIColor.blue
        polylineRender.lineWidth = 3
        return polylineRender
    }
}
