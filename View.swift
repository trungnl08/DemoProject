//
//  View.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit

class View: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 50, y: 100, width: 100, height: 100)
              // add username
              let userName = UILabel(frame: CGRect(x: 50, y: 200, width: 100, height: 25))
              userName.text = "Hello World"
              userName.backgroundColor = .lightGray
              userName.textAlignment = .center
              userName.textColor = .blue
              view.addSubview(userName)
              
              // add button
              let button = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 225))
              button.backgroundColor = .clear
              button.addTarget(self, action: #selector(tap), for: .touchDragInside)
              view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    @objc func tap() {
            print("taped")
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
