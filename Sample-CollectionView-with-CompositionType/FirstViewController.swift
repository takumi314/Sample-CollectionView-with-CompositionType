//
//  FirstViewController.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/01.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var dataSource = FirstCollectionViewDataSource([])

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(
            FirstCollectionViewCell.nib,
            forCellWithReuseIdentifier: FirstCollectionViewCell.identifier
        )
        collectionView.dataSource = dataSource
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        render(["A", "B", "D", "E", "F", "G"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @objc func camera() {
        let picker = ImagePickerViewControllerDelegate(
            imagePicker: UIImagePickerController(),
            presenting: self,
            handler: { (result) in
                switch result {
                case .success(let image):
                    vc.dialog(with: image)
                    break
                default:
                    break
                }
        })
        picker.openCamera(presenting: self)
        self.picker = picker
    }

    // MARK: - Privates

    func render(_ items: [String]) {
        dataSource.setItems(items)
        collectionView.reloadData()
    }

}

