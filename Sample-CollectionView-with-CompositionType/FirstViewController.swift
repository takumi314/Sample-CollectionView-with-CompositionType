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
    private var picker: ImagePickerViewControllerDelegate?

    private var dataSource = FirstCollectionViewDataSource([])
    private var imageDataSource = ImageLogDataSource([])

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(FirstCollectionViewCell.self)
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
            handler: { [weak self](result) in
                switch result {
                case .success(let image):
                    self?.dialog(with: image)
                    break
                default:
                    break
                }
        })
        picker.openCamera(presenting: self)
        self.picker = picker
    }

    func dialog(with image: UIImage) {
        let alert = UIAlertController(title: "Name",
                                      message: "Give a photo name.",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { [weak self]_ in
                                let name = alert.textFields?.first?.text ?? "No name"
                                self?.imageDataSource.set(ImageLog(image: image, name: name, date: Date()))
        })
        alert.addAction(ok)
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Privates

    func render(_ items: [String]) {
        dataSource.set(items)
        collectionView.reloadData()
    }

}

