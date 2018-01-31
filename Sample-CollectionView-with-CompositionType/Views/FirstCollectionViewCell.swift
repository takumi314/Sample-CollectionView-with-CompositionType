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

        if let view
            = UINib(
                nibName: "FirstCollectionViewCell",
                bundle: nil
            ).instantiate(
                withOwner: self,
                options: nil
            ).first as? UIView {
            contentView.addSubview(view)
        }
    }

    func setText(_ text: String) {
        label.text = text
    }

}
