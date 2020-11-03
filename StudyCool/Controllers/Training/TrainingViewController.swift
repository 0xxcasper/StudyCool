//
//  TrainingViewController.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import UIKit
import SVProgressHUD

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
    @IBOutlet weak var vSuccess: SuccessView!
    @IBOutlet weak var btnCheck: PMSuperButton!
    
    var currentIndexWord: Int! = 0
    var currentTrainingType: TrainingType! = .learn {
        didSet{
            self.setShowView()
        }
    }
    var words: [WordModel]?
    //
    var typeTopic: String!
    var fileName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getData()
    }
    
    private func getData() {
        JsonHelper.mapJSONFileWithLocalOrFirebase(fileName: fileName, type: typeTopic, { [weak self] Words in
            guard let strSelf = self else { return }
            if let words = Words {
                let tenWord = words.prefix(3) // Remove me later
                strSelf.words = Array(tenWord) // Remove me later
//                strSelf.words = words
                strSelf.vLearn.word = words[strSelf.currentIndexWord]
                strSelf.vSuccess.word = words[strSelf.currentIndexWord]
            } else {
                strSelf.dismiss()
            }
        })
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
            case .listen:
                if (self.vSuccess.isHidden) {
                    self.vSuccess.isHidden = false
                    // TODO: Check Wrong or Right
                    if let answer = self.vListern.txfAnswer.text, words![currentIndexWord].word.lowercased() == answer.lowercased() {
                        self.vSuccess.vBG.backgroundColor = UIColor(rgb: 0x00924C)
                        self.words![currentIndexWord].listened = true
                    } else {
                        self.vSuccess.vBG.backgroundColor = UIColor(rgb: 0xA3211E)
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
                        self.vSuccess.vBG.backgroundColor = UIColor(rgb: 0x00924C)
                        self.words![currentIndexWord].writen = true
                    } else {
                        self.vSuccess.vBG.backgroundColor = UIColor(rgb: 0xA3211E)
                    }
                } else {
                    self.vSuccess.isHidden = true
                    if (self.currentIndexWord + 1 >= self.words!.count) {
                        self.progressView.setProgress(1.0, animated: true)
                        Firebase.shared.setDataTopicLearned(words: self.words!, titleTopic: typeTopic)
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
