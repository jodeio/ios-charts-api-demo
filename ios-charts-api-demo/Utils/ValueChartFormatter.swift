//
//  BarChartFormatter.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 21/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import Charts

class ValueChartFormatter: NSObject, IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value) % labels.count
        if index >= 0 && index < labels.count{
            return labels[index]
        }
        return ""
    }
    
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
}
