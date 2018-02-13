//
//  ImageLog.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/03.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class ImageLog: NSObject, NSCoding {

    struct ImageLogKey {
        static let image    = "LOG_THUMBNAIL"
        static let name     = "LOG_NAME"
        static let date     = "LOG_DATE"
        static let data     = "LOG_DATA"
    }

    let image: UIImage
    let name: String
    let date: Date
    let imageData: ImageData

    init(image: UIImage, name: String, date: Date) {
        let thumbnail = UIImageJPEGRepresentation(image, 0.001) ?? Data()

        self.image  = UIImage(data: thumbnail)!
        self.name   = name
        self.date   = date
        self.imageData = ImageData(image: image, name: name, date: date)
    }

    init(_ data: ImageData) {
        let path = data.fileURL
        let imageData = try? Data(contentsOf: path)

        self.image = UIImage(data: imageData ?? Data()) ?? UIImage()
        self.name = data.name
        self.date = data.date
        self.imageData = data
    }

    func encode(with aCoder: NSCoder) {
        let jpgData = UIImageJPEGRepresentation(image, 1.0) ?? Data()

        aCoder.encode(jpgData, forKey: ImageLogKey.image)
        aCoder.encode(name, forKey: ImageLogKey.name)
        aCoder.encode(date, forKey: ImageLogKey.date)
        aCoder.encode(imageData, forKey: ImageLogKey.data)
    }

    required init?(coder aDecoder: NSCoder) {
        let data = aDecoder.decodeObject(forKey: ImageLogKey.image) as! Data

        self.image = UIImage(data: data)!
        self.name = aDecoder.decodeObject(forKey: ImageLogKey.name) as! String
        self.date = aDecoder.decodeObject(forKey: ImageLogKey.date) as! Date
        self.imageData = aDecoder.decodeObject(forKey: ImageLogKey.data) as! ImageData
    }

}

class ImageData: NSObject, NSCoding {

    private struct ImageDataKey {
        static let fileURL = "IMAGE_URL"
        static let name    = "IMAGE_NAME"
        static let date    = "IMEGE_DATE"
    }

    let fileURL: URL
    let name: String
    let date: Date

    init(image: UIImage, name: String, date: Date) {
        let data = UIImageJPEGRepresentation(image, 1.0)! as NSData
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let file = "\(name)" + "_" + "\(Date().hashValue)" + ".jpg"
        let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)!

        data.write(to: path, atomically: true)
    
        let flag = FileManager.default.isReadableFile(atPath: path.path)
        print(flag)

        self.fileURL    = path
        self.name       = name
        self.date       = date
    }

    required init?(coder aDecoder: NSCoder) {
        self.fileURL  = aDecoder.decodeObject(forKey: ImageDataKey.fileURL) as! URL
        self.name       = aDecoder.decodeObject(forKey: ImageDataKey.name) as! String
        self.date       = aDecoder.decodeObject(forKey: ImageDataKey.date) as! Date
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.fileURL, forKey: ImageDataKey.fileURL)
        aCoder.encode(self.name, forKey: ImageDataKey.name)
        aCoder.encode(self.date, forKey: ImageDataKey.date)
    }

    var image: UIImage? {
        get {
            let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            guard FileManager.default.isReadableFile(atPath: dir) else {
                return nil
            }
            let data = NSData(contentsOf: self.fileURL)

            let image = UIImage(data: data! as Data)
            return image
        }
    }

}

