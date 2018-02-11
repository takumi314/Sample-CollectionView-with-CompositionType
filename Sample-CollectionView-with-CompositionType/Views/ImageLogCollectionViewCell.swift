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

    private var longPressBatch: ActionBatch<IndexPath>?
    private var tapBatch: ActionBatch<IndexPath>?

    var imageLog: ImageLog?

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.isHidden = true
    }

    func willRecognizeLognPress(batch: ActionBatch<IndexPath>) {
        self.longPressBatch = batch
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didRecognize)))
    }

    func willRecognizeTap(batch: ActionBatch<IndexPath>) {
        self.tapBatch = batch
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didShortTap)))
    }


    // MARK: - Private

    @objc private func didRecognize(_ longPress: UILongPressGestureRecognizer) {
        self.isHighlighted = true
        longPressBatch?.execute()
    }

    @objc private func didShortTap(_ tap: UITapGestureRecognizer) {
        tapBatch?.execute()
    }

}

extension ImageLogCollectionViewCell: ViewModelItem {
    // default Implementation
}
