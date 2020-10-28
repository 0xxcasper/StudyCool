//
//  StudyVC.swift
//  StudyCool
//
//  Created by Sang on 9/24/20.
//

import UIKit

class StudyVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.registerXibFile(StudyCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension StudyVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(StudyCell.self, for: indexPath)
        let topic = topics[indexPath.row]
        cell.img.image = UIImage(named: topic.image)
        cell.lbl.text = topic.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 16*3)/2
        return CGSize(width: width, height: width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = topics[indexPath.row]

        let trainVC = TrainingViewController()
        trainVC.fileName = topic.fileName
        trainVC.typeTopic = topic.type
        self.present(controller: trainVC)
    }

}

