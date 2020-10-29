//
//  ReviewVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit
//import Charts
import MSBBarChart

class ReviewVC: BaseViewController {
//    @IBOutlet weak var vBarChart: BarChartView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var barChart: MSBBarChartView!
    
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
                barChart.isHidden = false
                self.emptyHistoryView.isHidden = true
                self.drawChart()
            }
        }
    }
    
    var typeTopic: String!
    var fileName: String!
//    var dataEntries: [BarChartDataEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.isHidden = true
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func setUpView() {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
                
//        let leftAxis = vBarChart.leftAxis
//        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
//        leftAxis.labelPosition = .outsideChart
//
//        vBarChart.drawGridBackgroundEnabled = false
        
    }
    
    func getData() {
        JsonHelper.mapJSONFileWithLocalOrFirebase(fileName: fileName, type: typeTopic) { [weak self] Words in
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
    
    func drawChart() {
        
        let dataPoints = [level0, level1, level2, level3, level4, level5]
        let labels = ["Level 0", "Level 1", "Level 2", "Level 3", "Level 4", "Level 5"]
        
        barChart.setOptions([.isGradientBar(true), .yAxisNumberOfInterval(5)])

        barChart.assignmentOfGradient = [0.0..<0.25: [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)], 0.25..<0.50: [#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)], 0.50..<0.75: [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)], 0.75..<1.0: [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]]
        
        barChart.setDataEntries(values: dataPoints)
        barChart.setXAxisUnitTitles(labels)
        barChart.start()
        
//        for i in 0..<dataPoints.count {
//          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataPoints[i]))
//          dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
//        chartDataSet.colors = ChartColorTemplates.material()
//
//        let chartData = BarChartData(dataSet: chartDataSet)
//
//        vBarChart.data = chartData
    }
    
    func addEmptyHistoryView() {
        view.addSubview(emptyHistoryView)
        emptyHistoryView.fillSuperviewNotSafe()
        view.sendSubviewToBack(self.emptyHistoryView)
        emptyHistoryView.delegate = self
    }
    
    @IBAction func onPressDismiss(_ sender: UIButton) {
        self.dismiss()
    }
}


extension ReviewVC: EmptyHistoryViewDelegate {
    func onStartLearnPress() {
        let trainVC = TrainingViewController()
        trainVC.fileName = self.fileName
        trainVC.typeTopic = self.typeTopic
        self.present(controller: trainVC)
//        self.tabBarController?.selectedIndex = 1
    }
}
