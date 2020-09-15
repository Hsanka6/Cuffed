//
//  CollectionViewExample.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/14/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class CollectionViewExample: UIViewController {
//    var uicv = UICollectionView?
    let colors = GradientBackground()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructBackground()
        // self.view.addSubview(label)
    }
    func constructBackground() {
        let backgroundLayer = self.colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
}
