//
//  CustomView.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit

class DemoView : UIView {
    var nameLabel: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        // add user name
        nameLabel = UILabel(frame: CGRect(x: 0,
                                          y: frame.size.height*4/5,
                                          width: frame.size.width,
                                          height: frame.size.height/5))
        nameLabel!.text = "Hello"
        nameLabel!.backgroundColor = .lightGray
        nameLabel!.textAlignment = .center
        nameLabel!.textColor = .blue
        self.addSubview(nameLabel!)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }}

class CustomView: UIViewController {
    
    @IBOutlet weak var viewcustom: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let demo = DemoView(frame: CGRect(x: 50, y: 100, width: 100, height: 125))
        viewcustom.addSubview(demo)
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
