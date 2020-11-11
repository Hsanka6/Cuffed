//
//  VicesAndFamilyPlansTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 11/11/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class VicesAndFamilyPlansTableViewCell: UITableViewCell {
    static var reuseIdentifier = "VicesAndFamilyPlansTableViewCell"
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var mcAnswers: [MultipleChoiceAnswer]?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
    }

    func configure(mcAnswers: [MultipleChoiceAnswer]) {
        self.mcAnswers = mcAnswers
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
      collectionView.register(SmallAttributeCollectionViewCell.self, forCellWithReuseIdentifier: SmallAttributeCollectionViewCell.reuseIdentifier)
    }


}

extension VicesAndFamilyPlansTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mcAnswers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallAttributeCollectionViewCell.reuseIdentifier, for: indexPath) as? SmallAttributeCollectionViewCell else { return UICollectionViewCell()}
        if let mc = mcAnswers?[indexPath.row] {
            cell.initialize(mcAnswer: mc)
       }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 80
        let height = 80 // or what height you want to do
        return CGSize(width: width, height: height)
    }
    
}
