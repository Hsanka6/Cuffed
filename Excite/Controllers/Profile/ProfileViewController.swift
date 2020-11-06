//
//  ProfileViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/29/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: UserViewModel
    var tableView = UITableView()
    
    enum ProfileSections: String, CaseIterable {
       case userPhotos
       case userQuestions
    }
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        navBarSetup()
       
    }
    
    func tableViewSetup() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.register(BigPhotoCollectionViewCell.self, forCellReuseIdentifier: BigPhotoCollectionViewCell.reuseIdentifier)
//        tableView.register(UserTableTableViewCell.self, forCellReuseIdentifier: UserTableTableViewCell.reuseIdentifier)
//        tableView.register(UserTablePersonalityTableViewCell.self, forCellReuseIdentifier: UserTablePersonalityTableViewCell.reuseIdentifier)
//        tableView.register(UserPrioritiesTableTableViewCell.self, forCellReuseIdentifier: UserPrioritiesTableTableViewCell.reuseIdentifier)
//        tableView.register(MultipleChoiceTableViewCell.self, forCellReuseIdentifier: MultipleChoiceTableViewCell.reuseIdentifier)
//        tableView.register(MultipleChoiceTableViewCell.self, forCellReuseIdentifier: MultipleChoiceTableViewCell.newreuseIdentifier)
        tableView.register(QuestionsTableViewCell.self, forCellReuseIdentifier: QuestionsTableViewCell.profileReuseIdentifier)
        
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    func navBarSetup() {
        view.backgroundColor = .white
               self.parent?.title = "BOBBOI"
               let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(action))
               self.parent?.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func action(sender: UIBarButtonItem) {
        let newViewController = ProfileEditViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileSections.allCases[section] {
        case .userPhotos:
            return 1
        case .userQuestions:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileSections.allCases[indexPath.section] {
        case .userPhotos:
            let cell = tableView.dequeueReusableCell(withIdentifier: BigPhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? BigPhotoCollectionViewCell
            if let photos = viewModel.user?.profile?.photos {
                 cell?.configure(photos: photos)
            }
            return cell ?? UITableViewCell()
        case .userQuestions:
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.profileReuseIdentifier, for: indexPath) as? QuestionsTableViewCell
            if let fr = viewModel.user?.profile?.freeResponse {
                 cell?.initialize(freeResponse: fr, isTableView: false)
            }
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileSections.allCases[indexPath.section] {
        case .userPhotos:
           return 350
        case .userQuestions:
            return 125
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return ProfileSections.allCases.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           switch ProfileSections.allCases[section] {
           case .userPhotos:
               return 25
           case .userQuestions:
               return 25
           }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       switch ProfileSections.allCases[section] {
       default:
           return ""
       }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.clipsToBounds = true
        header?.tintColor = .clear
        header?.textLabel?.textColor = UIColor.black
        header?.textLabel?.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
   
}
