//
//  ImagePickerViewControllerDelegate.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure
    case cancelled
}

class ImagePickerViewControllerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var originalImage: UIImage?
    private let handler: (ImageResult) -> ()
    private let viewController: UIViewController
    private let imagePicker: UIImagePickerController

    init(imagePicker: UIImagePickerController, presenting viewController: UIViewController, handler: @escaping (ImageResult) -> ()) {
        self.imagePicker = imagePicker
        self.viewController = viewController
        self.handler = handler
    }

    func openCamera(presenting viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            imagePicker.cameraDevice = .rear
            imagePicker.delegate = self
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            handler(.failure)
            return
        }
        picker.dismiss(animated: true, completion: nil)
        handler(.success(image))
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        handler(.cancelled)
        picker.dismiss(animated: true, completion: nil)
    }

}
