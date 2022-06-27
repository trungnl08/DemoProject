//
//  Drawing.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit
class rectangle: UIView {
    override func draw(_ rect: CGRect) {
        // create path
        let path = createPath()
        
        // fill
        let fillColor = UIColor.orange
        fillColor.setFill()
        path.fill()
    }
    
    func createPath() -> UIBezierPath {
        let path = UIBezierPath(rect: self.bounds)
        return path
    }

}

class Drawing: UIViewController {
    let drawer = rectangle(frame: CGRect(x: 30, y: 300, width: 350, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawer)
        drawLine(start: CGPoint(x:250, y: 100), end: CGPoint(x: 250, y: 600))

        // Do any additional setup after loading the view.
    }
    func drawLine(start: CGPoint, end : CGPoint){
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.close()
        let shapeLayer = CAShapeLayer()
               shapeLayer.strokeColor = UIColor.blue.cgColor
               shapeLayer.lineWidth = 1.0
               shapeLayer.path = path.cgPath
               
               //ADD LAYER
               self.view.layer.addSublayer(shapeLayer)
        
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
