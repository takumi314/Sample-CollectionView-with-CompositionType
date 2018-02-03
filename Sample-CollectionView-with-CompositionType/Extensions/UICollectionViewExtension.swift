//
//  UICollectionViewExtension.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<T: CellIdentifiable>(_ className: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }

}
