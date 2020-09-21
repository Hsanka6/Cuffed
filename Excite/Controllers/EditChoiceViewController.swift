//
//  EditChoiceViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 8/31/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
protocol EditChoiceViewControllerDelegate: class {
    func mcEdited( questions: [MultipleChoiceAnswer], identifier: String)
}

class EditChoiceViewController: UIViewController {
    let button = MultipleChoiceButton()
    var choices: [String]?
    var selectedAnswer: String?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var questions: [MultipleChoiceAnswer]?
    var profile: Profile?
    var index: Int?
    weak var delegate: EditChoiceViewControllerDelegate?
    var identifier: String?


    override func viewDidLoad() {
        super.viewDidLoad()
             
        self.view.backgroundColor = .white
        setUpCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setUpCollectionView() {
        self.view.addSubview(collectionView)
       collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(5)
            make.height.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.allowsSelection = true
              //collectionView.clipsToBounds = false
              //collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(MultipleChoiceCollectionViewCell.self, forCellWithReuseIdentifier: MultipleChoiceCollectionViewCell.reuseIdentifier)
         
        let editButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(action))
             self.navigationItem.rightBarButtonItem  = editButton
        
    }
    
    @objc func action(sender: UIBarButtonItem) {
        guard let questions = questions, let identifier = identifier else {
            return
        }
        delegate?.mcEdited(questions: questions, identifier: identifier)
        self.navigationController?.popViewController(animated: true)
    }
    

}


extension EditChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choices?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleChoiceCollectionViewCell.reuseIdentifier, for: indexPath) as? MultipleChoiceCollectionViewCell, let choice = choices?[indexPath.row], let selectedAnswer = selectedAnswer {
            cell.initialize(answerChoice: choice, selectedChoice: selectedAnswer)
            if choice == selectedAnswer {
                cell.button.selectedStyling()
            } else {
                cell.button.styleButton()
            }
            cell.layer.cornerRadius = 15
            //cell.viewController = self
            return cell
        
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = UIScreen.main.bounds.width/2 - (25)
           let height = CGFloat(50) // or what height you want to do
           return CGSize(width: width, height: height)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MultipleChoiceCollectionViewCell
        guard let index = index else { return }
        cell?.button.selectedStyling()
        self.selectedAnswer = (choices?[indexPath.row])!
        questions?[index].answer = self.selectedAnswer ?? "default"
        cell?.button.changeState()
        collectionView.reloadData()
    }
    
}
