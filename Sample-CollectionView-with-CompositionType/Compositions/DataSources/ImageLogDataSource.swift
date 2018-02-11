//
//  ImageLogDataSource.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class ImageLogDataSource: NSObject, UICollectionViewDataSource {

    var deletingAction: ((IndexPath) -> ())?
    var previewAction: ((IndexPath) -> ())?

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
        cell.willRecognizeLognPress(
            batch: ActionBatch(input: indexPath,
                               gestureAction: { [weak self] (indexPath) in
                                guard let action = self?.deletingAction else { return }
                                action(indexPath)
            })
        )
        cell.willRecognizeTap(
            batch: ActionBatch(input: indexPath,
                               gestureAction: { [weak self] (indexPath) in
                                guard let action = self?.previewAction else { return }
                                action(indexPath)
            })
        )
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

    func log(at index: Int) -> ImageLog {
        return imageLogs[index]
    }

    func deleteAll() {
        imageLogs.removeAll()
    }

    func delete(at index: Int) {
        let log = imageLogs[index]
        let url = log.imageData.fileURL
        let manager = FileManager.default
        if manager.isDeletableFile(atPath: url.absoluteString) {
            try! manager.removeItem(at: url)
        }
        let store = DataStore<[ImageLog]>(UserDefaults.standard)
        if var items = store.load() {
            items.remove(at: index)
            store.save(items)
            imageLogs.remove(at: index)
        }
    }

}
