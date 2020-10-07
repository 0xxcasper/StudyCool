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

let topic = "ielts"

class TrainingViewController: BaseViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var vLearn: LearnView!
    @IBOutlet weak var vListern: ListernView!
    @IBOutlet weak var vWrite: WriteView!
    @IBOutlet weak var vSuccess: SuccessView!
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
        if let words = JsonHelper.readJSONFromFile(fileName: "words", type: topic) {
            let tenWord = words.prefix(10) // GET 10 word
            self.words = Array(tenWord)
            self.vLearn.word = words[currentIndexWord]
            self.vSuccess.word = words[currentIndexWord]
            self.words![currentIndexWord].learnLevel += 1
        }
    }
    
    private func setUpView() {   
        progressView.layer.cornerRadius = 8
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        vSuccess.isHidden = true
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
    
    @IBAction func onPressBack(_ sender: Any) {
        self.dismiss()
    }
    
    @IBAction func onPressCheck(_ sender: PMSuperButton) {
        if (self.words != nil && self.currentIndexWord < self.words!.count) {
            self.view.endEditing(true)
            switch self.currentTrainingType {
            case .learn:
                self.vSuccess.word = words![currentIndexWord]
                self.vSuccess.isHidden = true
                self.currentTrainingType = .listen
                self.vListern.word = words![currentIndexWord]
                self.words![currentIndexWord].learnLevel += 1
            case .listen:
                if (self.vSuccess.isHidden) {
                    self.vSuccess.isHidden = false
                    // TODO: Check Wrong or Right
                    if let answer = self.vListern.txfAnswer.text, words![currentIndexWord].word.lowercased() == answer.lowercased() {
                        self.vSuccess.vBG.backgroundColor = .green
                        self.words![currentIndexWord].listenLevel += 1
                    } else {
                        self.vSuccess.vBG.backgroundColor = .red
                    }
                } else {
                    self.vSuccess.isHidden = true
                    self.currentTrainingType = .write
                    self.vWrite.word = words![currentIndexWord]
                }
            case .write:
                if (self.vSuccess.isHidden) {
                    self.vSuccess.isHidden = false
                    // TODO: Check Wrong or Right
                    if  self.vWrite.wordAnwers.compactMap({ $0.text }).joined().lowercased() == words![currentIndexWord].word.lowercased() {
                        self.vSuccess.vBG.backgroundColor = .green
                        self.words![currentIndexWord].writeLevel += 1
                    } else {
                        self.vSuccess.vBG.backgroundColor = .red
                    }
                } else {
                    self.vSuccess.isHidden = true
                    if (self.currentIndexWord + 1 >= self.words!.count) {
                        self.progressView.setProgress(1.0, animated: true)
                        Firebase.shared.setDataTopicLearned(words: self.words!, titleTopic: topic)
                        self.dismiss()
                    } else {
                        self.currentIndexWord = self.currentIndexWord + 1
                        self.currentTrainingType = .learn
                        self.vLearn.word = words![currentIndexWord]
                        self.progressView.setProgress(Float(self.currentIndexWord)/Float(self.words!.count), animated: true)
                    }
                }
            default: break
            }
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
