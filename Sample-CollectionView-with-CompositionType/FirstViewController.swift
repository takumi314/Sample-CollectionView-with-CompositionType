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
    private var pinterestiveTransitionDelegate: PinterestiveAnimationController?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.setCollectionViewLayout(FirstCollectionViewFlowLayout() , animated: false)
        collectionView.register(ImageLogCollectionViewCell.self)
        collectionView.dataSource = imageDataSource
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touched)))

        imageDataSource.deletingAction = { [unowned self] (indexPath) in
            let alert = UIAlertController(title: "Atteion",
                                          message: "Are you sure ?",
                                          preferredStyle: .alert)
            let ok = UIAlertAction(
                title: "OK",
                style: .destructive,
                handler: { _ in
                    self.delete(at: indexPath)
            })
            let cancel = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert,
                         animated: true,
                         completion: nil)
        }

        imageDataSource.previewAction = { [unowned self](indexPath) in
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? ImageLogCollectionViewCell else { return }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
            let position = CGPoint(x: cell.frame.origin.x - self.collectionView.contentOffset.x,
                                   y: cell.frame.origin.y - self.collectionView.contentOffset.y + UIApplication.shared.statusBarFrame.size.height)

            self.pinterestiveTransitionDelegate
                = PinterestiveAnimationController(
                    position: position,
                    cell: cell,
                    isPresent: true
            )
            vc.transitioningDelegate = self.pinterestiveTransitionDelegate
            self.present(vc, animated: true, completion: nil)
        }

        let items = fetch(DataOf: ImageLog.self)
        render(items)
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        super.viewWillAppear(animated)

        if collectionView.subviews.filter({ $0 is UIButton }).isEmpty {
            let screen = UIScreen.main.bounds
            let tabBar = UIApplication.shared.keyWindow?.rootViewController?.tabBarController?.tabBar.frame.size.height ?? 100
            let frame = CGRect(x: screen.width - 70, y: screen.height - tabBar - 50, width: 50, height: 50)
            let button = UIButton()
            button.frame = frame
            button.isSelected = false
            button.backgroundColor = .purple
            button.addTarget(self, action: #selector(camera), for: .touchDown)
            view.addSubview(button)
            Timer.scheduledTimer(
                withTimeInterval: 3.0,
                repeats: false,
                block: { _ in
                    UIView.animate(
                        withDuration: 1.0,
                        animations: {
                            button.isHidden = true
                            button.isUserInteractionEnabled = false
                    })

            })
        }
    }

    @objc func touched() {
        guard let button = view.subviews.filter({ $0 is UIButton }).first, button.isHidden else {
            return
        }
        button.isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 1.0,
            animations: {
                button.isHidden = false
                button.isUserInteractionEnabled = true
        }, completion: { _ in
            Timer.scheduledTimer(
                withTimeInterval: 2.0,
                repeats: false,
                block: { _ in
                    UIView.animate(
                        withDuration: 1.0,
                        animations: {
                            button.isHidden = true
                            button.isUserInteractionEnabled = false
                    })
            })
        })
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        if let button = view.subviews.filter({ $0 is UIButton }).first {
            coordinator.animate(
                alongsideTransition: { _ in
                    let screen = UIScreen.main.bounds
                    let tabBar = UIApplication.shared.keyWindow?.rootViewController?.tabBarController?.tabBar.frame.size.height ?? 100
                    button.frame = CGRect(x: screen.width - 70,
                                          y: screen.height - tabBar - 10,
                                          width: button.bounds.width,
                                          height: button.bounds.height)
            }, completion: { _ in
                button.isHidden = false
                button.isUserInteractionEnabled = true
                Timer.scheduledTimer(
                    withTimeInterval: 2.0,
                    repeats: false,
                    block: { _ in
                        UIView.animate(
                            withDuration: 2.0,
                            animations: {
                                button.isHidden = true
                                button.isUserInteractionEnabled = false
                        })
                })
            })
        }
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
                                self?.update(ImageLog(image: image, name: name, date: Date()) )
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
        var items = fetch(DataOf: ImageLog.self)

        // save
        items.append(item)
        push(items: items)

        // update view
        imageDataSource.set(items)
        collectionView.reloadData()
    }

    private func delete(at indexPath: IndexPath) {
        collectionView.performBatchUpdates({ [unowned self] in
            self.imageDataSource.delete(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
        }, completion: { [unowned self] _ in
            self.collectionView.reloadData()
        })
    }

    func fetch<T>(DataOf type: T.Type) -> [T] {
        let store = DataStore<[T]>(UserDefaults.standard)
        return store.load() ?? []
    }

    func push<T>(items: [T]) {
        let store = DataStore<[T]>(UserDefaults.standard)
        store.save(items)
    }

}

