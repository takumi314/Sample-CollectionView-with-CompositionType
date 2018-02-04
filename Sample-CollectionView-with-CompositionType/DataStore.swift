//
//  DataStore.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/05.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import Foundation

struct DataStore<U> {
    typealias T = U
    let repository: Persistable

    init(_ repository: Persistable) {
        self.repository = repository
    }

    func save(_ data: U) {
        repository.save(data)
    }

    func load() -> U? {
        return repository.load()
    }
}
