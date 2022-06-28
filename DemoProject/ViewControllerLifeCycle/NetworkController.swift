//
//  NetworkController.swift
//  DemoProject
//
//  Created by Frog Pepe on 27/06/2022.
//

import UIKit
import Alamofire
import ObjectMapper


class CurrentWeather : Mappable {
    var temp_c : Double?
    var country : String?
    var uv : Double?
    
    init() {}
    required init?(map: Map){}
    
    func mapping(map: Map) {
        temp_c <- map["current.temp_c"]
        country <- map["location.country"]
        uv <- map["current.uv"]
    }
}

class NetworkController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelUV: UILabel!
    @IBOutlet weak var labelTempe: UILabel!
    @IBOutlet weak var labelLocate: UILabel!
    @IBOutlet weak var inputOutlet: UITextField!
    
    
    @IBAction func searchButton(_ sender: Any) {
        if(inputOutlet.text != ""){
            getApi()
            
        } else {
            inputOutlet.placeholder = "Type something"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputOutlet.delegate = self
        labelUV.text = ""
        labelTempe.text = ""
        labelLocate.text = ""
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputOutlet.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputOutlet.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(inputOutlet.text != ""){
            return true
        } else {
            inputOutlet.placeholder = "Type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        getApi()
    }
    func getApi(){
        AF.request("https://api.weatherapi.com/v1/current.json?key=fa1e63115c004a5fbd632725222706&q=\(inputOutlet.text!)&aqi=no",method: .get).responseString {(response) in
            switch response.result {
            case .success(let data):
                let resultConverted = Mapper<CurrentWeather>().map(JSONString: data)
                guard let country = resultConverted?.country else {return}
                guard let temp_c = resultConverted?.temp_c else {return}
                guard let uv = resultConverted?.uv else {return}
                
                self.labelLocate.text = country
                self.labelTempe.text = "\(temp_c)"
                self.labelUV.text = "\(uv)"
            case .failure(let err):
                print(err)
            default:
                break
            }
        }
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
