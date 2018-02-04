//
//  ImageLog.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

struct ImageLog {
    let image: UIImage
    let name: String
    let date: Date
    let imageData: ImageData

    init(image: UIImage, name: String, date: Date) {
        let thumneil = UIImageJPEGRepresentation(image, 0.001) ?? Data()

        self.image  = UIImage(data: thumneil) ?? UIImage()
        self.name   = name
        self.date   = date
        self.imageData = ImageData(image: image, name: name, date: date)
    }

    init(_ data: ImageData) {
        let path = data.imageData
        let imageData = try? Data(contentsOf: path)

        self.image = UIImage(data: imageData ?? Data()) ?? UIImage()
        self.name = data.name
        self.date = data.date
        self.imageData = data
    }
}

class ImageData: NSObject, NSCoding {

    var imageData: URL
    var name: String
    var date: Date

    init(image: UIImage, name: String, date: Date) {
        let data = UIImageJPEGRepresentation(image, 1.0) ?? Data()
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let file = "\(name)" + "_" + "\(Date().timeIntervalSince1970)"
        let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)!
        try! data.write(to: path, options: .atomic)

        self.imageData  = path
        self.name       = name
        self.date       = date
    }

    init(log: ImageLog) {
        let data = UIImageJPEGRepresentation(log.image, 1.0) ?? Data()
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let file = "\(log.name)" + "_" + "\(Date().timeIntervalSince1970)"
        let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)!
        try! data.write(to: path, options: .atomic)

        self.imageData  = path
        self.name       = log.name
        self.date       = log.date
    }

    required init?(coder aDecoder: NSCoder) {
        self.imageData  = aDecoder.decodeObject(forKey: "IMAGE_DATA") as! URL
        self.name       = aDecoder.decodeObject(forKey: "IMAGE_NAME") as! String
        self.date       = aDecoder.decodeObject(forKey: "IMEGE_DATE") as? Date ?? Date()

        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageData, forKey: "IMAGE_DATA")
        aCoder.encode(name, forKey: "IMAGE_NAME")
        aCoder.encode(date, forKey: "IMAGE_DATE")
    }

}

