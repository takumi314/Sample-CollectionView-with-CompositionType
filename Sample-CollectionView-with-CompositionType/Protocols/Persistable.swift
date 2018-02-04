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

// MARK: - UserDefaults

extension Persistable where Self: UserDefaults {
    // Only declares for UserDefault
}

extension UserDefaults: Persistable {
    func save<T>(_ data: T) {
        self.set(data, forKey: "IMAGE_LOG")
    }
    func load<T>() -> T? {
        return object(forKey: "IMAGE_LOG") as? T
    }

}

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
