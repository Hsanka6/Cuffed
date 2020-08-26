//
//  ProfileEditViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ProfileEditViewController: UIViewController {
    var viewModel: ProfileViewModel?
    var tableView = UITableView()
    enum ProfileSections: String, CaseIterable {
        case userPhotos = "My Photos"
        case userTable  = "Personal Details"
        case userPersonality = "My Personality"
        case userPriorities = "My Priorities"
        case userVice = "My Vices"
        case userFamilyPlans = "My Family Plans"
                    
    }
     override func viewDidLoad() {
        self.viewModel = ProfileViewModel()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.register(ProfilePhotosCell.self, forCellReuseIdentifier: ProfilePhotosCell.reuseIdentifier)
        tableView.register(UserTableTableViewCell.self, forCellReuseIdentifier: UserTableTableViewCell.reuseIdentifier)
        tableView.register(UserTablePersonalityTableViewCell.self, forCellReuseIdentifier: UserTablePersonalityTableViewCell.reuseIdentifier)
        tableView.register(UserPrioritiesTableTableViewCell.self, forCellReuseIdentifier: UserPrioritiesTableTableViewCell.reuseIdentifier)
        tableView.register(MultipleChoiceTableViewCell.self, forCellReuseIdentifier: MultipleChoiceTableViewCell.reuseIdentifier)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            //make.centerX.equalToSuperview()
        }
        runOnBackgroundThread {
            NetworkRequesterMock().getUser { user in
                self.viewModel?.profile = user.profile
                self.tableView.reloadData()
            }
       }
    }
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileSections.allCases[section] {
        case .userPhotos:
            return 1
        case .userTable:
            return 1
        case .userPersonality:
            return 1
        case .userPriorities:
            return 1
        case .userVice:
            return 1
        case .userFamilyPlans:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileSections.allCases[indexPath.section] {
        case .userTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableTableViewCell.reuseIdentifier, for: indexPath) as? UserTableTableViewCell
            cell?.selectionStyle = .none
            if let details = viewModel?.profile?.personalDetails {
                cell?.initialize(personalDetails: details)
            }
            return cell ?? UITableViewCell()
        case .userPhotos:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotosCell.reuseIdentifier, for: indexPath) as? ProfilePhotosCell
            cell?.viewController = self
            if let photos = viewModel?.profile?.photos {
                 cell?.configure(photos: photos)
            }
            return cell ?? UITableViewCell()
        case .userPersonality:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTablePersonalityTableViewCell.reuseIdentifier, for: indexPath) as? UserTablePersonalityTableViewCell
            if let personalities = viewModel?.profile?.personalityAnswers {
                 cell?.initialize(personality: personalities)
            }
            return cell ?? UITableViewCell()
        case .userPriorities:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserPrioritiesTableTableViewCell.reuseIdentifier, for: indexPath) as? UserPrioritiesTableTableViewCell
            cell?.initialize(priorities: ["Travel", "Starting a Family", "Parent Approval", "Serious Relationship", "Short Term Relationship"])
            return cell ?? UITableViewCell()
        case .userVice:
            let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceTableViewCell.reuseIdentifier, for: indexPath) as? MultipleChoiceTableViewCell
            if let familyPlans = viewModel?.profile?.familyPlans {
                cell?.initialize(questions: familyPlans)
            }
            return cell ?? UITableViewCell()
        case .userFamilyPlans:
            let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceTableViewCell.reuseIdentifier, for: indexPath) as? MultipleChoiceTableViewCell
            if let vices = viewModel?.profile?.vices {
                cell?.initialize(questions: vices)
            }
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           switch ProfileSections.allCases[indexPath.section] {
           case .userTable:
               return 400
           case .userPhotos:
               return 225
           case .userPersonality:
               return 320
           case .userPriorities:
               return 195
           case .userVice:
               return 160
           case .userFamilyPlans:
               return 120
        }
       }
    func numberOfSections(in tableView: UITableView) -> Int {
       return ProfileSections.allCases.count
   }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           switch ProfileSections.allCases[section] {
           case .userTable, .userPhotos, .userPersonality, .userPriorities, .userVice, .userFamilyPlans:
               return 25
           }
    }
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           switch ProfileSections.allCases[section] {
           default:
               return ProfileSections.allCases[section].rawValue
           }
       }
       func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as? UITableViewHeaderFooterView
            header?.textLabel?.clipsToBounds = true
            header?.tintColor = .lightGray
            header?.textLabel?.textColor = UIColor.black
            header?.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
       }
}
