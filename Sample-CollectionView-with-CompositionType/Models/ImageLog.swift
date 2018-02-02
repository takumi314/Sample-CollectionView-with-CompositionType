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

    init(image: UIImage, name: String, date: Date) {
        self.image  = image
        self.name   = name
        self.date   = date
    }

}
