//
//  FirstCollectionViewFlowLayout.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/02.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

let numberOfColumn: CGFloat = 2
let screenWidth = UIScreen.main.bounds.width
let minimumSpacing: CGFloat = 10

class FirstCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Initializer

    override init() {
        super.init()

        let itemOfWidth = (screenWidth - 4 * minimumSpacing) / numberOfColumn
        let itemSizs = CGSize(width: itemOfWidth, height: itemOfWidth)

        self.itemSize = itemSizs
        self.minimumLineSpacing = minimumSpacing
        self.minimumInteritemSpacing = minimumSpacing
        self.scrollDirection = .vertical

        let horizontalInset = CGFloat((screenWidth - numberOfColumn * itemOfWidth) * 0.25)
        let verticalInset   = CGFloat((screenWidth - itemSizs.height) * 0.5)

        self.sectionInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
