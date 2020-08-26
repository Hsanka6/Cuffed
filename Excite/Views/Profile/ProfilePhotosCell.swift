//
//  ProfilePhotosCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/17/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import Kingfisher

class ProfilePhotosCell: UITableViewCell {
     static var reuseIdentifier = "ProfilePhotosCell"
     public var viewController: UIViewController?
     public var photos = [String]()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
     override func awakeFromNib() {
         super.awakeFromNib()
     }
     func configure(photos: [String]) {
        self.photos = photos
        createCollectionView()
     }

    func createCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(5)
            make.height.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        contentView.clipsToBounds = false
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)
    }
}

extension ProfilePhotosCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell {
        cell.initialize()
        cell.configure(photo: photos[indexPath.row])
        return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/3 - (40/2)
        let height = CGFloat(100) // or what height you want to do
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell {
            ImagePickerManager().pickImage(self.viewController!) { image in
                cell.configureWithImage(photo: image)
            }
        }
    }
}
