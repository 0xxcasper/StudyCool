//
//  ReviewVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit
import Charts

class ReviewVC: BaseViewController {
    @IBOutlet weak var vBarChart: BarChartView!
    
    lazy var emptyHistoryView: EmptyHistoryView = {
        let emptyView = EmptyHistoryView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    var level0 = 0
    var level1 = 0
    var level2 = 0
    var level3 = 0
    var level4 = 0
    var level5 = 0
    
    var isEmptyHistory = true {
        didSet {
            if (isEmptyHistory) {
                self.addEmptyHistoryView()
            } else {
                vBarChart.isHidden = false
                self.drawChart()
            }
        }
    }
    
    var dataEntries: [BarChartDataEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        vBarChart.isHidden = true
        getData()
    }
    
    func getData() {
        topics.forEach{ topic in
            JsonHelper.mapJSONFileWithLocalOrFirebase(fileName: topic.fileName, type: topic.type) { [weak self] Words in
                guard let strSelf = self else { return }
                if let words = Words {
                    words.forEach{ word in
                        if (word.level == 1) {
                            strSelf.level1 = strSelf.level1 + 1
                        } else if (word.level == 2) {
                            strSelf.level2 = strSelf.level2 + 1
                        } else if (word.level == 3) {
                            strSelf.level3 = strSelf.level3 + 1
                        } else if (word.level == 4) {
                            strSelf.level4 = strSelf.level4 + 1
                        } else if (word.level == 5) {
                            strSelf.level5 = strSelf.level5 + 1
                        } else {
                            strSelf.level0 = strSelf.level0 + 1
                        }
                    }
                    if (strSelf.level1 == 0 && strSelf.level2 == 0 && strSelf.level3 == 0 && strSelf.level4 == 0 && strSelf.level5 == 0) {
                        strSelf.isEmptyHistory = true
                    } else {
                        strSelf.isEmptyHistory = false
                    }
                }
            }
        }
    }
    
    func drawChart() {
        let dataPoints = [level0, level1, level2, level3, level4, level5]
        print("KLJAKLF\(dataPoints)")
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataPoints[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.stackLabels = ["H", "L"]
        let chartData = BarChartData(dataSet: chartDataSet)
        vBarChart.data = chartData
    }
    
    func addEmptyHistoryView() {
        view.addSubview(emptyHistoryView)
        emptyHistoryView.fillSuperviewNotSafe()
        emptyHistoryView.delegate = self
    }
}


extension ReviewVC: EmptyHistoryViewDelegate {
    func onStartLearnPress() {
        self.tabBarController?.selectedIndex = 1
    }
}
