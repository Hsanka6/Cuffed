//
//  BigPhotoCollectionViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 10/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class BigPhotoCollectionViewCell: UITableViewCell {
    static var reuseIdentifier = "BigPhotosCell"
    public var photos = [String]()
    public var images = [UIImage]()
    weak var delegate: ProfilePhotoCellDelegate?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.backgroundColor = UIColor.white
      contentView.clipsToBounds = true
      collectionView.clipsToBounds = false
      collectionView.showsHorizontalScrollIndicator = true
      collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.removeFromSuperview()
        collectionView.reloadData()
    }
}


extension BigPhotoCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let width = collectionView.frame.width - (15)
        let height = CGFloat(350) // or what height you want to do
        return CGSize(width: width, height: height)
    }
}
