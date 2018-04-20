//
//  Status.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import ObjectMapper

struct Status<T>: Mappable where T: Mappable{
    
    var statusCode:Int?
    var result:T?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        statusCode <- map["status_code"]
        result <- map["result"]
    }
}
