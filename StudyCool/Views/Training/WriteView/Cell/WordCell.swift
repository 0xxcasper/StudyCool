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
        self.setViewCorner(radius: 10)
        self.setShadow(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), opacity: 0.6, offSet: CGSize(width: 0, height: 0), radius: 3)
        lblWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
