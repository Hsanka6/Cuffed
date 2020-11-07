//
//  CardViewPhotos.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

class PhotosCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.backgroundColor = .white
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = "Add Photos"
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        addBehavior()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    func addBehavior() {
        print("INSIDE OF PHOTOS CARD VIEW")
    }
}
