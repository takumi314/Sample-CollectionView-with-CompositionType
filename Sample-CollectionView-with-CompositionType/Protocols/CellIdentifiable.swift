//
//  CellIdentifiable.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/02.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

protocol CellIdentifiable {

    static var nib: UINib { get }

    static var identifier: String { get }

}

extension CellIdentifiable {

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

}
