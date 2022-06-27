//
//  StackViewController.swift
//  DemoProject
//
//  Created by Frog Pepe on 27/06/2022.
//

import UIKit

class StackViewController: UIViewController {

    @IBOutlet weak var stackview: UIStackView!
    @IBAction func toggleVerti(_ sender: Any) {
        if(self.stackview.axis == .vertical){
            
        
        self.stackview.axis = .horizontal
        } else {
            self.stackview.axis = .vertical
        }
    }

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
