//
//  HomeViewController.swift
//  StudyCool
//
//  Created by admin on 28/10/2020.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
    func setUpView() {
        tbView.registerXibFile(HomeCell.self)
        tbView.separatorStyle = .none
        tbView.dataSource = self
        tbView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HomeCell.self, for: indexPath)
        cell.delegate = self
        let topic = topics[indexPath.row]
        cell.lblTitle.text = topic.title
        cell.img.image = UIImage(named: topic.image)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: HomeCellDelegate {
    func didOnPressTraing(indexPath: IndexPath) {
        let topic = topics[indexPath.row]

        let trainVC = TrainingViewController()
        trainVC.fileName = topic.fileName
        trainVC.typeTopic = topic.type
        self.present(controller: trainVC)
    }
    
    func didOnPressReview(indexPath: IndexPath) {
        let topic = topics[indexPath.row]

        let reviewVC = ReviewVC()
        reviewVC.fileName = topic.fileName
        reviewVC.typeTopic = topic.type
        self.present(controller: reviewVC)
    }
}
