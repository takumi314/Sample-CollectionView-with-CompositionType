//
//  ImageLogCollectionViewCell.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class ImageLogCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.isHidden = true
    }

}

extension ImageLogCollectionViewCell: ViewModelItem {
    // default Implementation
}
