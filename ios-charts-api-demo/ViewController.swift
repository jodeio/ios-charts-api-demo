//
//  ViewController.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    var grades = [95, 92, 91, 85, 75]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Render graph
        updateGraph()
    }
    
    func updateGraph(){
        var lineChartDataEntry = [ChartDataEntry]()
        
        for i in 0..<grades.count {
            // Init individual grades
            let value = ChartDataEntry(x: Double(i), y: Double(grades[i]))
            lineChartDataEntry.append(value)
        }
        
        // Populate data set from the entries
        let line1 = LineChartDataSet(values: lineChartDataEntry, label: "Grade")
        
        // Customize graph
        line1.colors = [UIColor.green]
        
        // Add data set to chart data
        let data = LineChartData()
        data.addDataSet(line1)
        
        // Render data to the view, it will trigger an update
        lineChartView.data = data
        
        // Add title
        lineChartView.chartDescription?.text = "Line Graph - Manual Data Entry"
    }
    
}

