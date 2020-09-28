//
//  TrainingViewController.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import UIKit

enum TrainingType {
    case learn
    case listen
    case write
}

class TrainingViewController: BaseViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var vLearn: LearnView!
    @IBOutlet weak var vListern: ListernView!
    @IBOutlet weak var vWrite: WriteView!
    @IBOutlet weak var btnCheck: PMSuperButton!
    
    var currentIndexWord: Int! = 0
    var currentTrainingType: TrainingType! = .learn {
        didSet{
            self.setShowView()
        }
    }
    var words: [WordModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getData()
    }
    
    private func getData() {
        if let words = JsonHelper.readJSONFromFile(fileName: "words", type: "ielts") {
            let tenWord = words.prefix(20) // GET 20 word
            self.words = Array(tenWord)
            self.vLearn.word = words[currentIndexWord]
        }
    }
    
    private func setUpView() {   
        progressView.layer.cornerRadius = 8
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        vListern.delegate = self
        vWrite.delegate = self
        self.setShowView()
    }
    
    private func setShowView() {
        switch self.currentTrainingType {
        case .learn:
            vLearn.isHidden = false
            vListern.isHidden = true
            vWrite.isHidden = true
            self.setAbleButtonCheck(isEnable: true)
        case .listen:
            vLearn.isHidden = true
            vListern.isHidden = false
            vWrite.isHidden = true
            vListern.txfAnswer.text = ""
            self.setAbleButtonCheck(isEnable: false)
        case .write:
            vLearn.isHidden = true
            vListern.isHidden = true
            vWrite.isHidden = false
            self.setAbleButtonCheck(isEnable: false)
        default:
            break
        }
    }
    
    private func setAbleButtonCheck(isEnable: Bool) {
        btnCheck.isEnabled = isEnable
        if (isEnable) {
            btnCheck.gradientStartColor = .orange
            btnCheck.gradientEndColor = .purple
        } else {
            btnCheck.gradientStartColor = .gray
            btnCheck.gradientEndColor = .gray
        }
    }

    @IBAction func onPressCheck(_ sender: PMSuperButton) {
        if (self.words != nil && self.currentIndexWord + 1 < self.words!.count) {
            self.view.endEditing(true)
            switch self.currentTrainingType {
            case .learn:
                self.currentTrainingType = .listen
                self.vLearn.word = words![currentIndexWord]
            case .listen:
                self.currentTrainingType = .write
                self.vWrite.word = words![currentIndexWord]
            case .write:
                self.currentIndexWord = self.currentIndexWord + 1
                self.currentTrainingType = .learn
                self.vLearn.word = words![currentIndexWord]
                self.progressView.setProgress(Float(self.currentIndexWord)/Float(self.words!.count), animated: true)
            default: break
            }
        } else {
            self.dismiss()
        }
    }
}

extension TrainingViewController: ListernViewDelegate, WriteViewDelegate {
    
    func textFieldEditing(_ isEmpty: Bool) {
        self.setAbleButtonCheck(isEnable: !isEmpty)
    }
    
    func customKeyboardEditing(_ isEmpty: Bool) {
        self.setAbleButtonCheck(isEnable: !isEmpty)
    }
}
