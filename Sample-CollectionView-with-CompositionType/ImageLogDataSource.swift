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

    func add(_ log: ImageLog) {
        imageLogs.append(log)
    }

    func deleteAll() {
        imageLogs.removeAll()
    }

    func delete(at indexPath: IndexPath) {
        imageLogs.remove(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageLogs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)

        return cell
    }

}
