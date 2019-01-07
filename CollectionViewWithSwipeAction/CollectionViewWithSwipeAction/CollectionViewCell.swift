//
//  CollectionViewCell.swift
//  CollectionViewWithSwipeAction
//
//  Created by Migu on 2019/1/7.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class CollectionViewCell: SwipableCollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enableSwipeDelete = true
        
//        contentView.clipsToBounds = true
//        contentView.layer.cornerRadius = 3
//        contentView.backgroundColor = UIColor.white
    }
}
