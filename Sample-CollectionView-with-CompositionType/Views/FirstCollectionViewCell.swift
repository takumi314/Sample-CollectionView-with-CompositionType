//
//  FirstCollectionViewCell.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/01.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension FirstCollectionViewCell: ViewModelItem {
    // default implementation
}
