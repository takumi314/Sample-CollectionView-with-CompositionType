//
//  FirstCollectionViewDataSource.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/01.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class FirstCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var items = [String]()

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
