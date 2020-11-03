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
    @IBOutlet weak var vBG: UIView!
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vBG.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        vBG.layer.cornerRadius = 10
        vBG.setShadow(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), opacity: 0.2, offSet: CGSize(width: 0, height: 0), radius: 3)
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
