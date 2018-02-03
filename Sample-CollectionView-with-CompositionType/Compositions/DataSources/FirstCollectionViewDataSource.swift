//
//  FirstCollectionViewDataSource.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/01.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class FirstCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // MARK: - Header

    private var items: [String]

    // MARK: - Initializer

    init(_ items: [String] = []) {
        self.items = items
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FirstCollectionViewCell.identifier,
            for: indexPath) as? FirstCollectionViewCell else {
            let cell = FirstCollectionViewCell()
                cell.setItem(items[indexPath.row])
            cell.setItem(items[indexPath.row])
            return cell
        }
        cell.setItem(items[indexPath.row])
        return cell
    }

}

extension FirstCollectionViewDataSource: DataSourcing {

    func set(_ item: String) {
        self.items.append(item)
    }

    func set(_ items: [String]) {
        self.items = items
    }

    func deleteAll() {
        items.removeAll()
    }

    func delete(at index: Int) {
        items.remove(at: index)
    }

}
