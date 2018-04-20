//
//  GradesPerQuarter.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import ObjectMapper

struct GradesPerQuarter {
    var firstQuarter: Double?
    var secondQuarter: Double?
    var thirdQuarter: Double?
    var fourthQuarter: Double?
}

extension GradesPerQuarter: Mappable{
    init?(map: Map) {
        //
    }
    
    mutating func mapping(map: Map) {
        firstQuarter <- map["first_quarter"]
        secondQuarter <- map["second_quarter"]
        thirdQuarter <- map["third_quarter"]
        fourthQuarter <- map["fourth_quarter"]
    }
}
