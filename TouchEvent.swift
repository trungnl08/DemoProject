//
//  TouchEvent.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit

class TouchEvent: UIViewController {
    var path = UIBezierPath()
        var firstLocation = CGPoint.zero
        var shapeLayer = CAShapeLayer()
    @IBOutlet weak var viewGreen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
setupView()
        // Do any additional setup after loading the view.
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               if touch.view == viewGreen {
                   let location = touch.location(in: view)
                   viewGreen.center = location
               }
           }
        if let location = touches.first?.location(in: view) {
            
            path.removeAllPoints()
            path.move(to: firstLocation)
            path.addLine(to: location)
            shapeLayer.path = path.cgPath
        }
       }
    func setupView(){
           view.layer.addSublayer(shapeLayer)
           self.shapeLayer.lineWidth = 2
           self.shapeLayer.strokeColor = UIColor.blue.cgColor
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let location = touches.first?.location(in: view){
               firstLocation = location
           }
       }
       
//       override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//           if let location = touches.first?.location(in: view) {
//
//               path.removeAllPoints()
//               path.move(to: firstLocation)
//               path.addLine(to: location)
//               shapeLayer.path = path.cgPath
//           }
//       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
