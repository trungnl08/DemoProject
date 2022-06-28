//
//  ApiManager.swift
//  DemoProject
//
//  Created by Frog Pepe on 28/06/2022.
//

import Foundation
import Alamofire
import ObjectMapper

typealias Completion = () -> Void
enum ApiError: Error {
    case error(String)
    case errorURL
    var localizedDescription : String {
        switch self {
        case .error(let err):
            return err
        case .errorURL:
            return "URL string error"
        }
    }
}

class ApiManager {
    init() {
        
    }
    func requestApi(urlString: String, completion: @escaping ([EarthQuake]?, ApiError?)-> Void){
        AF.request(urlString, method: .get).responseString {
            (response) in
            switch response.result {
            case .success(let data):
                debugPrint("Data")
                let head = data.firstIndex(of: "{")
                let last = data.lastIndex(of: "}")
                let temp = data[head!...last!]
                let resultConverted = Mapper<EarthQuakes>().map(JSONString: String(temp))
                guard let res = resultConverted?.features else {return}
                completion(res, nil)
            case .failure(let err):
                debugPrint("error there")
                debugPrint(err)
            default:
                break
            }
            
        }
    }
}
