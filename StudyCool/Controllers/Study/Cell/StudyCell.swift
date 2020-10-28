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
        self.setShadow(color: UIColor.gray, offSet: CGSize(width: 0, height: 2))
    }

}
