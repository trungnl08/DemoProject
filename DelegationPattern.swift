//
//  DelegationPattern.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit
protocol subViewB {
    func checking(pass:String)
}
class ViewA: subViewB {
    func checking(pass:String) {
        print(pass)
    }
    
    
}
class ViewB {
    var delegate: subViewB?
    
}

class DelegationPattern: UIViewController {

    @IBAction func Click(_ sender: Any) {
        let viewA = ViewA()
        let viewB = ViewB()
        viewB.delegate = viewA
        viewB.delegate?.checking(pass: "abc")
    }
    @IBOutlet weak var viewb: UIView!
    @IBOutlet weak var viewa: UIView!
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


