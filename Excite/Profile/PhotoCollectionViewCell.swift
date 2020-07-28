//
//  PhotoCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/20/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "photo"

    var imageView = UIImageView()
    func initialize() {
        self.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
    }
    func configure(photo: String) {
        imageView.kf.setImage(with: URL(string: photo))
    }
    
    func configureWithImage(photo: UIImage) {
        imageView.image = photo
    }
    
}
