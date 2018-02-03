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

    private var imageDataSource = ImageLogDataSource([])

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(FirstCollectionViewFlowLayout() , animated: false)
        collectionView.register(ImageLogCollectionViewCell.self)
        collectionView.dataSource = imageDataSource

        render([])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let screen = UIScreen.main.bounds
        let frame = CGRect(x: screen.width / 2, y: screen.height - 100, width: 50, height: 50)
        let button = UIButton()
        button.frame = frame
        button.isSelected = false
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(camera), for: .touchDown)
        collectionView.addSubview(button)

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
                                self?.update(ImageLog(image: image, name: name, date: Date()))

        })
        alert.addAction(ok)
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Privates

    private func render(_ items: [ImageLog]) {
        imageDataSource.set(items)
        collectionView.reloadData()
    }

    private func update(_ item: ImageLog){
        imageDataSource.set(item)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

