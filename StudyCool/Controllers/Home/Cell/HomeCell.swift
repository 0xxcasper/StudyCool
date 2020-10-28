//
//  HomeCell.swift
//  StudyCool
//
//  Created by admin on 28/10/2020.
//

import UIKit

protocol HomeCellDelegate: class {
    func didOnPressTraing(indexPath: IndexPath)
    func didOnPressReview(indexPath: IndexPath)
}

class HomeCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    weak var delegate: HomeCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPressTraing(_ sender: UIButton) {
        if let indexP = self.indexPath {
            delegate.didOnPressTraing(indexPath: indexP)
        }
    }
    
    @IBAction func onPressReview(_ sender: UIButton) {
        if let indexP = self.indexPath {
            delegate.didOnPressReview(indexPath: indexP)
        }
    }
    
}
