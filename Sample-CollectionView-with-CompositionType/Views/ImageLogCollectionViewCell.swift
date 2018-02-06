//
//  ImageLogCollectionViewCell.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

struct ActionBatch<T> {
    var input: T
    var gestureAction: ((T) -> ())
    func execute() {
        gestureAction(input)
    }
}

class ImageLogCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    // MARK: - Property

    private var batch: ActionBatch<IndexPath>?

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.isHidden = true
    }

    func willRecognizeLognPress(batch: ActionBatch<IndexPath>) {
        self.batch = batch
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didRecognize)))
    }

    // MARK: - Private

    @objc private func didRecognize(_ longPress: UILongPressGestureRecognizer) {
        batch?.execute()
    }

}

extension ImageLogCollectionViewCell: ViewModelItem {
    // default Implementation
}
