//
//  ImageLogDataSource.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class ImageLogDataSource: NSObject, UICollectionViewDataSource {

    private var imageLogs = [ImageLog]()

    // MARK: - Initializer

    init(_ items: [ImageLog] = []) {
        self.imageLogs = items
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageLogs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageLogCollectionViewCell.identifier, for: indexPath) as? ImageLogCollectionViewCell else {
            let cell = ImageLogCollectionViewCell()
            cell.setItem(imageLogs[indexPath.row])
            return cell
        }
        cell.setItem(imageLogs[indexPath.row])

        return cell
    }

}

extension ImageLogDataSource: DataSourcing {

    func set(_ item: ImageLog) {
        imageLogs.append(item)
    }

    func set(_ items: [ImageLog]) {
        self.imageLogs = items
    }

    func deleteAll() {
        imageLogs.removeAll()
    }

    func delete(at index: Int) {
        imageLogs.remove(at: index)
    }

}
