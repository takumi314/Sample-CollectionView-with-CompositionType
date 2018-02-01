//
//  FirstViewController.swift
//  Sample-CollectionView-with-CompositionType
//
//  Created by NishiokaKohei on 2018/02/01.
//  Copyright © 2018年 Kohey.Nishioka. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UICollectionView!

    private var dataSource = FirstCollectionViewDataSource([])

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            FirstCollectionViewCell.nib,
            forCellWithReuseIdentifier: FirstCollectionViewCell.identifier
        )
        tableView.dataSource = dataSource
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        render(["A", "B", "D", "E", "F", "G"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func render(_ items: [String]) {
        dataSource.setItems(items)
        tableView.reloadData()
    }

}

