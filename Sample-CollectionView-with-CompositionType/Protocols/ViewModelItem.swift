//
//  ViewModelItem.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/02.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import Foundation

protocol ViewModelItem {
    associatedtype T
    func setItem(_ item: T)
}

extension ViewModelItem where Self: FirstCollectionViewCell {
    typealias T = String

    func setItem(_ item: String) {
        label.text = item
    }
}
