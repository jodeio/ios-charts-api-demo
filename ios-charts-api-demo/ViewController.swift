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
    @IBOutlet weak var lcvManualGraph: LineChartView!
    @IBOutlet weak var lcvApiGraph: LineChartView!
    @IBOutlet weak var bcvApiGraph: BarChartView!
    
    // Local data
    let grades = [95, 92, 91, 85]
    let quarters = ["First", "Second","Third","Fourth"]
    
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
        lcvManualGraph.xAxis.valueFormatter = ValueChartFormatter(labels: quarters)
        lcvManualGraph.xAxis.granularityEnabled = true
        lcvManualGraph.xAxis.granularity = 1
        lcvManualGraph.xAxis.labelPosition = .bottom
        line1.colors = [UIColor.green]
        
        // Add data set to chart data
        let data = LineChartData()
        data.addDataSet(line1)
        
        // Render data to the view, it will trigger an update
        lcvManualGraph.data = data
        
        // Add title
        lcvManualGraph.chartDescription?.text = "Line Graph - Manual Data Entry"
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
                    self.onRetrieveGradesSuccess(grades: responseStatus?.result?.gradesPerSubject as [GradesPerSubject]!)
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
        firstQuarter.accessibilityLabel = "aw"
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
        lcvApiGraph.xAxis.valueFormatter = ValueChartFormatter(labels: quarters)
        lcvApiGraph.xAxis.granularityEnabled = true
        lcvApiGraph.xAxis.granularity = 1
        lcvApiGraph.xAxis.labelPosition = .bottom
        line1.colors = [UIColor.green]
        
        // Add data set to chart data
        let data = LineChartData()
        data.addDataSet(line1)
        
        // Render data to the view, it will trigger an update
        lcvApiGraph.data = data
        
        // Add title
        lcvApiGraph.chartDescription?.text = "Line Graph - API Data Entry"
        
    }
    
    func onRetrieveGradesSuccess(grades: [GradesPerSubject]){
        var subjects = [String]()
        
        // Create data entry instance
        var firstQuarterDataEntries: [BarChartDataEntry] = []
        var secondQuarterDataEntries: [BarChartDataEntry] = []
        var thirdQuarterDataEntries: [BarChartDataEntry] = []
        var fourthQuarterDataEntries: [BarChartDataEntry] = []
        
        // Assigning values
        for i in 0..<grades.count {
            // Appending values to a bar data entries
            firstQuarterDataEntries.append(BarChartDataEntry(x: 0, y: grades[i].firstQuarter!))
            secondQuarterDataEntries.append(BarChartDataEntry(x: 1, y: grades[i].secondQuarter!))
            thirdQuarterDataEntries.append(BarChartDataEntry(x: 2, y: grades[i].thirdQuarter!))
            fourthQuarterDataEntries.append(BarChartDataEntry(x: 3, y: grades[i].fourthQuarter!))
            
            // Assign subject
            subjects.append(grades[i].subjectName!)
            
        }
        // Create data set from the entries
        let firstQuarterDataSet = BarChartDataSet(values: firstQuarterDataEntries, label: "First")
        firstQuarterDataSet.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))

        let secondQuarterDataSet = BarChartDataSet(values: secondQuarterDataEntries, label: "Second")
        secondQuarterDataSet.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))

        let thirdQuarterDataSet = BarChartDataSet(values: thirdQuarterDataEntries, label: "Third")
        thirdQuarterDataSet.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))

        let fourthQuarterDataSet = BarChartDataSet(values: fourthQuarterDataEntries, label: "Fourth")
        fourthQuarterDataSet.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))

        
        // Assign data sets
        let dataSets: [BarChartDataSet] = [firstQuarterDataSet, secondQuarterDataSet, thirdQuarterDataSet, fourthQuarterDataSet]
    
        // Populate bar data from the data set array
        let barData = BarChartData(dataSets: dataSets)
        
        // Customize graph
        let groupSpace = 0.08
        let barSpace = 0.03
        let barWidth = 0.2
        let start = 0
        
        // Optional configurations
        bcvApiGraph.delegate = self
        bcvApiGraph.pinchZoomEnabled = true
        bcvApiGraph.rightAxis.enabled = false
        bcvApiGraph.dragEnabled =  true
        bcvApiGraph.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        bcvApiGraph.setVisibleXRangeMaximum(3)
        
        // Legend
        bcvApiGraph.legend.enabled = true
        bcvApiGraph.legend.horizontalAlignment = .right
        bcvApiGraph.legend.verticalAlignment = .top
        bcvApiGraph.legend.orientation = .vertical
        bcvApiGraph.legend.drawInside = true
        bcvApiGraph.legend.yOffset = 10.0;
        bcvApiGraph.legend.xOffset = 10.0;
        bcvApiGraph.legend.yEntrySpace = 0.0;

        // X-Axis
        bcvApiGraph.xAxis.labelCount = subjects.count
        bcvApiGraph.xAxis.valueFormatter = ValueChartFormatter(labels: subjects)
        bcvApiGraph.xAxis.granularityEnabled = true
        bcvApiGraph.xAxis.granularity = 1
        bcvApiGraph.xAxis.labelPosition = .bottom
        bcvApiGraph.xAxis.drawGridLinesEnabled = false
        bcvApiGraph.xAxis.centerAxisLabelsEnabled = true

        barData.barWidth = barWidth;
        barData.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
        
        
        // Render data to the view, it will trigger an update
        bcvApiGraph.data = barData
        
        // Add title
        bcvApiGraph.chartDescription?.text = "Bar Graph - Subjects"
        
    }
    
}

extension ViewController: ChartViewDelegate {
    
}
