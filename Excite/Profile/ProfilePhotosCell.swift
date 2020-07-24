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
     override func awakeFromNib() {
         super.awakeFromNib()
     }
     func configure(photos: [String]) {
        self.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.left.equalTo(10)
        }
        setupUI(photos: photos)
     }
    let stackView = UIStackView()
    func setupUI(photos: [String]) {
      // let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.spacing = 10
       self.addSubview(stackView)
       stackView.snp.makeConstraints { (make) in
           make.top.equalToSuperview()
           make.left.right.equalToSuperview()
           make.centerX.equalToSuperview()
       }
        let size = photos.count/2
        let photo1Array = Array(photos[0..<size])
        let photo2Array = Array(photos[size..<photos.count])
        stackView.isUserInteractionEnabled = true
        stackView.addArrangedSubview(makeStackViewOfImages(photos: photo1Array))
        stackView.addArrangedSubview(makeStackViewOfImages(photos: photo2Array))
    }

    func makeStackViewOfImages(photos: [String]) -> UIStackView {
       let stackView = UIStackView()
       stackView.axis = .horizontal
       stackView.spacing = 10
       for iter in 0...2 {
        stackView.addArrangedSubview(makeImageView(photo: photos[iter]))
       }
       return stackView
    }
    func makeImageView(photo: String) -> UIImageView {
       //let imageView = CustomImageView.setImage(image: UIImage(named: "user"))
       let widthOfImage = UIScreen.main.bounds.width/3 - (40/3)
       let imageView = UIImageView()
       imageView.kf.setImage(with: URL(string: photo))
       imageView.contentMode = .scaleToFill
       imageView.layer.cornerRadius = 10
       imageView.clipsToBounds = true
       imageView.isUserInteractionEnabled = true
       imageView.addTapGestureRecognizer {
        ImagePickerManager().pickImage(self.viewController!) { image in
                  imageView.image = image
              }
       }
       imageView.snp.makeConstraints { (make) in
           make.width.equalTo(widthOfImage)
           make.height.equalTo(100)
       }
       return imageView
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)

     // Configure the view for the selected state
    }
}
