//
//  MultipleChoiceButton.swift
//  Excite
//
//  Created by Haasith Sanka on 8/30/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MultipleChoiceButton: UIButton {
    
    public var select:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        styleButton()
    }
    
    public func selectedStyling() {
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor.gray
        self.setTitleColor(.gray, for: .selected)
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func styleButton() {
        self.setTitleColor(.gray, for: .normal)
        self.backgroundColor = UIColor.white
        self.setTitleColor(.gray, for: .selected)
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }

}
