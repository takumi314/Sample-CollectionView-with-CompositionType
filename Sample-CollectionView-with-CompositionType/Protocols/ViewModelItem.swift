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
    func setItem(_ item: String) {
        label.text = item
    }
    
}

extension ViewModelItem where Self: ImageLogCollectionViewCell {
    func setItem(_ item: ImageLog) {
        indicatorView.activityIndicatorViewStyle = .gray
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        imageView.image = item.image
        indicatorView.stopAnimating()
    }
}

