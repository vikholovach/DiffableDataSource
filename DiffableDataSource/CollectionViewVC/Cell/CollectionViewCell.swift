//
//  CollectionViewCell.swift
//  DiffableDataSource
//
//  Created by Viktor Golovach on 25.07.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 10
    }
    

}
