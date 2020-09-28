//
//  WriteView.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import Foundation
import UIKit

struct WriteWord {
    var index: Int!
    var text: String!
}

protocol WriteViewDelegate: class {
    func customKeyboardEditing(_ isEmpty: Bool)
}

class WriteView: BaseViewXib {
    
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    @IBOutlet weak var collectionTypeView: UICollectionView!
    @IBOutlet weak var boxAnswer: UIImageView!
    @IBOutlet weak var boxType: UIImageView!
    @IBOutlet weak var blurTitle: UIVisualEffectView!
    @IBOutlet weak var blurSubTitle: UIVisualEffectView!
    @IBOutlet weak var lblMean: UILabel!
    
    weak var delegate: WriteViewDelegate!

    var word: WordModel?{
        didSet{
            if word != nil {
                lblMean.text = word?.mean
                words.removeAll()
                wordAnwers.removeAll()
                words = word!.word!.createRandomCharacters()
            }
        }
    }
    
    var words: Array<WriteWord> = [] {
        didSet {
            collectionTypeView.reloadData()
        }
    }
    
    var wordAnwers: Array<WriteWord> = [] {
        didSet {
            collectionAnswerView.reloadData()
        }
    }

    override func firstInit() {
        setupView()
    }
    
    func setupView() {
        setupHeader()
        setupBox()
        setupCollectionView()
    }
    
    func setupHeader() {
        blurTitle.layer.cornerRadius = 8
        blurTitle.layer.masksToBounds = true
        
        blurSubTitle.layer.cornerRadius = 8
        blurSubTitle.layer.masksToBounds = true
    }
    
    func setupBox() {
        addShadow(view: boxAnswer)
        addShadow(view: boxType)
    }
    
    func addShadow(view: UIImageView) {
//        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.setShadow(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), offSet: CGSize(width: 1, height: 1), radius: 8)
    }
    
    func setupCollectionView() {
        collectionAnswerView.registerXibFile(WordCell.self)
        collectionAnswerView.dataSource = self
        collectionAnswerView.delegate = self
        
        collectionTypeView.registerXibFile(WordCell.self)
        collectionTypeView.dataSource = self
        collectionTypeView.delegate = self
    }
}

extension WriteView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView === collectionAnswerView ? wordAnwers.count :  words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(WordCell.self, for: indexPath)
        cell.isHidden = false
        cell.lblWord.text = collectionView === collectionAnswerView ? wordAnwers[indexPath.row].text : words[indexPath.row].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 16*7)/6
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView === collectionAnswerView) {
            if let index = wordAnwers[indexPath.row].index {
                let cell = collectionTypeView.cellForItem(at: IndexPath(item: index, section: 0)) as! WordCell
                cell.isHidden = false
                wordAnwers.remove(at: indexPath.row)
            }
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! WordCell
            cell.isHidden = true
            wordAnwers.append(words[indexPath.row])
        }
        delegate.customKeyboardEditing(wordAnwers.isEmpty)
    }

}
