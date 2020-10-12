//
//  UnderlinedTextField.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 10/11/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit
class UnderlinedTextField: UITextField {
    init(placeholder: String, frame: CGRect) {
        
        super.init(frame: .zero)
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width:  frame.size.width - 10, height: frame.size.height)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
        
        textAlignment   = .center
        textColor       = .white
        font            = UIFont.systemFont(ofSize: 20)
        
        keyboardAppearance  = .dark
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
