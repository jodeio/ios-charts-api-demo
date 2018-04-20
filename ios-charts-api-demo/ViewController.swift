//
//  ViewController.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var lcvApiGraph: LineChartView!
    
    // Local data
    let grades = [95, 92, 91, 85, 75, 95]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Render manual data entry graph
        renderManualDataEntryGraph()
        
        // Request for the json data
        requestApiDataEntry()
    }

    func renderManualDataEntryGraph(){
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
    
    func requestApiDataEntry(){
        
        // Request for data
        Alamofire
            .request(ChartService.getChartData())
            .validate()
            .responseObject{ (response: DataResponse<Status<Grades>>) in
                let responseStatus = response.result.value
                switch response.result{
                
                case .success:
                    self.onRetrieveGradesSuccess(grades: responseStatus?.result?.gradesPerQuarter as GradesPerQuarter!)
                    debugPrint(responseStatus as Status<Grades>!)
                
                case .failure(let error):
                    debugPrint(error)
                }
                
            }
        
    }
    
    func onRetrieveGradesSuccess(grades: GradesPerQuarter){
        // Create data entry instance
        var lineChartDataEntry = [ChartDataEntry]()
        
        // Assigning values (constant indexes, value)
        let firstQuarter = ChartDataEntry(x: 0, y: grades.firstQuarter!)
        let secondQuarter = ChartDataEntry(x: 1, y: grades.secondQuarter!)
        let thirdQuarter = ChartDataEntry(x: 2, y: grades.thirdQuarter!)
        let fourthQuarter = ChartDataEntry(x: 3, y: grades.fourthQuarter!)
        
        // Appending values to the data entry
        lineChartDataEntry.append(firstQuarter)
        lineChartDataEntry.append(secondQuarter)
        lineChartDataEntry.append(thirdQuarter)
        lineChartDataEntry.append(fourthQuarter)
        
        // Populate data set from the entries
        let line1 = LineChartDataSet(values: lineChartDataEntry, label: "Grade")
        
        // Customize graph
        line1.colors = [UIColor.green]
        
        // Add data set to chart data
        let data = LineChartData()
        data.addDataSet(line1)
        
        // Render data to the view, it will trigger an update
        lcvApiGraph.data = data
        
        // Add title
        lcvApiGraph.chartDescription?.text = "Line Graph - API Data Entry"
        
    }
    
}

