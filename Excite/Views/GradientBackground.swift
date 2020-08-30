//
//  Gradient.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 8/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class GradientBackground {
    var gl : CAGradientLayer
    init() {
        let colorTop = UIColor(hexString: "6CA0FF").cgColor
        let colorBottom = UIColor(hexString: "FF6299").cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
