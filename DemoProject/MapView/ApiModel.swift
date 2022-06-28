//
//  ApiModel.swift
//  DemoProject
//
//  Created by Frog Pepe on 28/06/2022.
//

import Foundation
import ObjectMapper
class EarthQuakes : Mappable {
    var features: [EarthQuake]?
    init(){}
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        features <- map["features"]
    }
}


class EarthQuake : Mappable {
    var url:String?
    var coordinates:[Double]?
    var mag: Double?
    init() {}
    required init?(map: Map){}
    
    func mapping(map: Map) {
        url <- map["properties.url"]
        coordinates <- map["geometry.coordinates"]
        mag <- map["properties.mag"]
    }
}
