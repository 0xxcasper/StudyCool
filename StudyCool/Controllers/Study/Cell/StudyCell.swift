//
//  StudyCell.swift
//  StudyCool
//
//  Created by admin on 28/10/2020.
//

import UIKit

class StudyCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = 10
        self.setShadow(color: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), opacity: 0.2, offSet: CGSize(width: 0, height: 0), radius: 3)
    }

}
