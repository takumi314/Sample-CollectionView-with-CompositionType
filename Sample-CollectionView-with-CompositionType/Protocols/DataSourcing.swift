//
//  DataSourcing.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import Foundation

protocol DataSourcing {

    associatedtype T

    func set(_ item: T)
    func set(_ items: [T])
    func deleteAll()
    func delete(at index: Int)

}
