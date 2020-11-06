//
//  QuestionsTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/26/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol QuestionTableViewCellDelegate: class {
    func questionsEdited(freeResponse: [FreeResponse])
    func didRequestBrowseQuestionsViewController(viewController: BrowseQuestionsViewController) 
}

class QuestionsTableViewCell: UITableViewCell {
    static var reuseIdentifier = "QuestionsTableViewCell"
    static var profileReuseIdentifier = "ProfileQuestionsTableViewCell"
    var tableView = UITableView()
    var freeResponse: [FreeResponse]?
    weak var delegate: QuestionTableViewCellDelegate?
    public var viewController: UIViewController?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initialize(freeResponse: [FreeResponse], isTableView: Bool) {
        self.freeResponse = freeResponse
        if isTableView {
            self.addSubview(tableView)
            self.tableView.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
                make.width.equalToSuperview()
                make.top.equalTo(5)
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(QuestionsDetailTableViewCell.self, forCellReuseIdentifier: QuestionsDetailTableViewCell.reuseIdentifier)
        } else {
            self.addSubview(collectionView)
            self.collectionView.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
                make.top.equalTo(5)
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
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(ProfileQuestionCollectionViewCell.self, forCellWithReuseIdentifier: ProfileQuestionCollectionViewCell.reuseIdentifier)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tableView.removeFromSuperview()
        tableView.reloadData()
    }

}

extension QuestionsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return freeResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsDetailTableViewCell.reuseIdentifier) as? QuestionsDetailTableViewCell
      if let free = freeResponse?[indexPath.row] {
          cell?.initialize(freeResponse: free)
      }
      return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = BrowseQuestionsViewController(index: indexPath.row, freeResponse: freeResponse)
        newViewController.delegate = self
        delegate?.didRequestBrowseQuestionsViewController(viewController: newViewController)
    }
}

extension QuestionsTableViewCell: BrowseQuestionsViewControllerDelegate {
    func questionsEdited(questions: [FreeResponse]) {
        delegate?.questionsEdited(freeResponse: questions)
    }
}


extension QuestionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return freeResponse?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileQuestionCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileQuestionCollectionViewCell
        if let free = freeResponse?[indexPath.row] {
            cell?.initialize(freeResponse: free)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 15
        let height = CGFloat(125) // or what height you want to do
        return CGSize(width: width, height: height)
    }
}
