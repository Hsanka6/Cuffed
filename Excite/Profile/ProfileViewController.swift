//
//  ProfileViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        self.parent?.title = "BOBBOI"
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(action))

        self.parent?.navigationItem.rightBarButtonItem = editButton
        makeUI() //single stackview
        //make() //nested stackview
    }
    @objc func action(sender: UIBarButtonItem) {
        let newViewController = ProfileEditViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func makeUI() {
//        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.cyan
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        self.view.addSubview(collectionView)
    }
}
