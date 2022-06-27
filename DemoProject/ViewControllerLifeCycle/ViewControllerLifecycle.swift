//
//  ViewControllerLifecycle.swift
//  DemoProject
//
//  Created by Frog Pepe on 27/06/2022.
//

import UIKit

class ViewControllerLifecycle: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Did load")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           print("viewWillAppear")
       }
       
       override func viewDidAppear(_ animated: Bool) {
           print("viewDidAppear")
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           print("viewWillDisappear")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           print("viewDidDisappear")
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
