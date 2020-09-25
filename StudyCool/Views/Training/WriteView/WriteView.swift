//
//  WriteView.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import Foundation
import UIKit

class WriteView: BaseViewXib {
    
    @IBOutlet weak var collectionAnswerView: UICollectionView!
    @IBOutlet weak var collectionTypeView: UICollectionView!
    
    var words: Array<String> = ["a", "b", "c", "d", "e", "f", "g", "h"] {
        didSet {
            collectionTypeView.reloadData()
        }
    }
    
    var wordAnwers: Array<String> = [] {
        didSet {
            collectionAnswerView.reloadData()
        }
    }

    override func firstInit() {
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
        cell.lblWord.text = collectionView === collectionAnswerView ? wordAnwers[indexPath.row] : words[indexPath.row]
        cell.backgroundColor = collectionView === collectionAnswerView ? .white : .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 16*7)/6
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView === collectionAnswerView) {
            if let index = words.firstIndex(of: wordAnwers[indexPath.row]) {
                let cell = collectionTypeView.cellForItem(at: IndexPath(item: index, section: 0)) as! WordCell
                cell.isHidden = false
                wordAnwers.remove(at: indexPath.row)
            }
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! WordCell
            cell.isHidden = true
            wordAnwers.append(words[indexPath.row])
        }
    }

}
