//
//  PhotoCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 7/20/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewCellDelegate: class {
    func selectedImage(images: [UIImage], index: Int)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "photo"
    weak var delegate: PhotoCollectionViewCellDelegate?
    var imageView = UIImageView()
    var images: [UIImage]?
    var index: Int?
    
    func initialize() {
        self.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        self.dropShadow()
    }
    func configure(photo: String) {
        imageView.kf.setImage(with: URL(string: photo))
    }
    
    func configureWithImage(photo: UIImage) {
        guard var images = images, let index = index else { return }
        imageView.image = photo
        images[index] = photo
        delegate?.selectedImage(images: images, index: index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.removeFromSuperview()
    }
}
