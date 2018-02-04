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

class TestContainer {
    let userDefault = UserDefaults.standard

    func hoge() {
        let store = DataStore<String>(UserDefaults())
        // 保存
        let input = "TEST"
        store.save(input)

        // 読み出し
        let output = store.load()

        assert(input == output, "データ永続化処理の動作チェック")
    }
}


