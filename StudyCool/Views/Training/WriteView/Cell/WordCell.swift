//
//  WordCell.swift
//  StudyCool
//
//  Created by admin on 25/09/2020.
//

import UIKit

class WordCell: UICollectionViewCell {

    @IBOutlet weak var lblWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        self.setViewCorner(radius: 5)
    }
}
