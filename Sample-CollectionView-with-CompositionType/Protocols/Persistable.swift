//
//  Persistable.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/04.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import Foundation

protocol Persistable {
    func save<T>(_ data: T)
    func load<T>() -> T?
}

