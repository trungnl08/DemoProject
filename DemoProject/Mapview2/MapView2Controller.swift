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
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension MapView2Controller: CLLocationManagerDelegate {
    
}
