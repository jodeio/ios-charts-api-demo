//
//  Grades.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import ObjectMapper

struct Grades {
    var gradesPerQuarter: GradesPerQuarter?
    var gradesPerSubject: [GradesPerSubject]?
}

extension Grades: Mappable{
    init?(map: Map) {
        //
    }
    
    mutating func mapping(map: Map) {
        gradesPerQuarter <- map["grades_per_quarter"]
        gradesPerSubject <- map["grades_per_subject"]
    }
}
