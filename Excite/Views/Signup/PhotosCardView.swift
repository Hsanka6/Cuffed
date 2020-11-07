//
//  CardViewPhotos.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PhotosCardView: UIView {
    public var photos = [String]()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var currentViewController: UIViewController
    init(photos: [String], frame: CGRect, currentViewController: UIViewController) {
        // check if photos is empty
        // if it is, then render a cell to add a picture
        // or we can just always render that picture
        // but render it at the end of the array
        // if photos.coiunt is < 9
        // then render the add photos o
        // else then don't let them add any more
        self.photos = photos
        self.photos.append("https://firebasestorage.googleapis.com/v0/b/excitedate-d3518.appspot.com/o/90zcGBSOWIOoK9SRBnWkDpOZYU23%2Fprofile_images%2F0?alt=media&token=a617c9e6-855c-418d-924c-12f76dbd2076")
        if self.photos.count < 9 {
            self.photos.append("add-photo")
        }
        self.currentViewController = currentViewController
        super.init(frame: frame)
//        self.backgroundColor = .green
        let questionLabel = UILabel()
//        questionLabel.textAlignment = .center
        questionLabel.backgroundColor = .white
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = "Add Photos"
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        createCollectionView()
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func createCollectionView() {
        self.addSubview(collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.height.equalTo(450)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }

}

extension PhotosCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell {
        cell.initialize()
        let imageString=photos[indexPath.row]
        if imageString == "add-photo" {
            cell.configure(photo: "https://firebasestorage.googleapis.com/v0/b/excitedate-d3518.appspot.com/o/static%2Fsignup%2Fadd-photo.png?alt=media&token=89c4fe3e-5ea4-436b-b547-52d9f9d82744")
        } else {
            cell.configure(photo: photos[indexPath.row])
        }
        return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.bounds.width/2) - 20
        let height = (self.collectionView.bounds.height/2) - 20
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell {
            ImagePickerManager().pickImage(self.currentViewController) { image in
                cell.configureWithImage(photo: image)
            }
        }
        if self.photos.count < 9 {
            self.photos.append("add-photo")
        }
        self.collectionView.reloadData()
    }
}
