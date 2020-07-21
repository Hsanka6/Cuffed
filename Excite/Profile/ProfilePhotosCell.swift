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
//        self.snp.makeConstraints { (make) in
//            make.top.equalTo(27)
//            make.right.equalTo(-10)
//            make.left.equalTo(10)
//        }
       // setupUI(photos: photos)
        print(photos.count)
        self.photos = photos
        createCollectionView()
     }
//    let stackView = UIStackView()
//    func setupUI(photos: [String]) {
//      // let stackView = UIStackView()
//       stackView.axis = .vertical
//       stackView.spacing = 10
//       self.addSubview(stackView)
//       stackView.snp.makeConstraints { (make) in
//           make.left.right.equalToSuperview()
//           make.centerX.equalToSuperview()
//       }
//        let size = photos.count/2
//        let photo1Array = Array(photos[0..<size])
//        let photo2Array = Array(photos[size..<photos.count])
//      //  stackView.isUserInteractionEnabled = true
//        stackView.addArrangedSubview(makeStackViewOfImages(photos: photo1Array))
//        stackView.addArrangedSubview(makeStackViewOfImages(photos: photo2Array))
//    }
//
//    func makeStackViewOfImages(photos: [String]) -> UIStackView {
//       let stackView = UIStackView()
//        stackView.snp.makeConstraints { (make) in
//            make.width.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(10)
//        }
//       stackView.axis = .horizontal
//        stackView.isUserInteractionEnabled = true
//       stackView.spacing = 10
//       for iter in 0...2 {
//        stackView.addArrangedSubview(makeImageView(photo: photos[iter]))
//       }
//       return stackView
//    }
//    func makeImageView(photo: String) -> UIImageView {
//       let imageView = CustomImageView()
//       let widthOfImage = UIScreen.main.bounds.width/3 - (40/3)
//       //let imageView = UIImageView()
//       imageView.kf.setImage(with: URL(string: photo))
//       imageView.contentMode = .scaleToFill
//       imageView.layer.cornerRadius = 10
//       imageView.clipsToBounds = true
//        self.bringSubviewToFront(imageView)
//
//        imageView.isUserInteractionEnabled = true
//       imageView.addTapGestureRecognizer {
//           print("is this nil \(self.viewController!)")
//           ImagePickerManager().pickImage(self.viewController!) { image in
//             imageView.image = image
//           }
//       }
//        print("\(imageView.isUserInteractionEnabled) is dumber")
//
//       imageView.snp.makeConstraints { (make) in
//           make.width.equalTo(widthOfImage)
//           make.height.equalTo(100)
//       }
//       return imageView
//    }
    func createCollectionView() {
//        let flowLayout = UICollectionViewFlowLayout()
//
//        // Now setup the flowLayout required for drawing the cells
//        //let space = 10.0 as CGFloat
//
//        // Set view cell size
//        flowLayout.itemSize = CGSize(width: bounds.height /*UIScreen.main.bounds.width/3 - (40/3)*/, height: bounds.height)
////
////        // Set left and right margins
////        flowLayout.minimumInteritemSpacing = space
////
////        // Set top and bottom margins
////        flowLayout.minimumLineSpacing = space
//
//        // Finally create the CollectionView
        addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
//
//        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: UserDetailTableViewCell.reuseIdentifier)
//
//        // Then setup delegates, background color etc.
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.white
//       let layout = UICollectionViewFlowLayout()
//       layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - (40/3), height: 100)
//       layout.scrollDirection = .horizontal
       contentView.clipsToBounds = false
       collectionView.clipsToBounds = false
       //collectionView.collectionViewLayout = layout
       collectionView.showsHorizontalScrollIndicator = true
       collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)
    }
}

extension ProfilePhotosCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
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
        let width = UIScreen.main.bounds.width/3 - (40/3)
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
