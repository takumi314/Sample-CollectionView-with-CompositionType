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

struct UserDefaultsKey {
    static let log = "IMAGE_LOG"
}

extension UserDefaults: Persistable {
    func save<T>(_ data: T) {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
        self.set(archivedData, forKey: UserDefaultsKey.log)
    }
    func load<T>() -> T? {
        guard let archivedData = object(forKey: UserDefaultsKey.log) as? Data else {
            print("No data in UserDefaults")
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as? T
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


