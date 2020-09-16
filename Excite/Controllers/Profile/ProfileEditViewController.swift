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

protocol ProfileDelegate {
    func familyPlanEdited(_ profileViewModel: ProfileViewModel, questions: [MultipleChoiceAnswer], gotProfile: Bool)
}


class ProfileEditViewController: UIViewController, ProfileDelegate {
    var viewModel: ProfileViewModel?
    var profile: Profile?
    var gotProfile: Bool = false
    static let notificationName = Notification.Name("myNotificationName")
    
    var user: User?
    var tableView = UITableView()
    enum ProfileSections: String, CaseIterable {
        case userPhotos = "My Photos"
        case userQuestions = "My Responses"
        case userTable  = "Personal Details"
        case userPersonality = "My Personality"
        case userPriorities = "My Priorities"
        case userVice = "My Vices"
        case userFamilyPlans = "My Family Plans"
                              
    }
    
    func familyPlanEdited(_ profileViewModel: ProfileViewModel, questions: [MultipleChoiceAnswer], gotProfile: Bool) {
        viewModel?.delegate = self
        self.viewModel = ProfileViewModel()
        profileViewModel.profile?.familyPlans = questions
        self.viewModel = profileViewModel
        for ques in questions {
            print("answer is \(ques.answer) ")
        }
        print(self.gotProfile)
           DispatchQueue.main.async {
              self.tableView.reloadData()
           }
       }
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        //NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: ProfileEditViewController.notificationName, object: nil)
        tableViewSetup()
        navBarSetup()
            
    }
    

    
    func navBarSetup() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveProfile))
        self.navigationItem.rightBarButtonItem  = saveButton
    }
    
    @objc func saveProfile() {
        let db = Firestore.firestore()
        guard let profile = profile else { return }
        db.collection("Users").document("test").setData([ "profile": profile.makeFromDict() ], merge: true)
    }
    
    func tableViewSetup() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.register(ProfilePhotosCell.self, forCellReuseIdentifier: ProfilePhotosCell.reuseIdentifier)
        tableView.register(UserTableTableViewCell.self, forCellReuseIdentifier: UserTableTableViewCell.reuseIdentifier)
        tableView.register(UserTablePersonalityTableViewCell.self, forCellReuseIdentifier: UserTablePersonalityTableViewCell.reuseIdentifier)
        tableView.register(UserPrioritiesTableTableViewCell.self, forCellReuseIdentifier: UserPrioritiesTableTableViewCell.reuseIdentifier)
        tableView.register(MultipleChoiceTableViewCell.self, forCellReuseIdentifier: MultipleChoiceTableViewCell.reuseIdentifier)
        tableView.register(MultipleChoiceTableViewCell.self, forCellReuseIdentifier: MultipleChoiceTableViewCell.newreuseIdentifier)
        tableView.register(QuestionsTableViewCell.self, forCellReuseIdentifier: QuestionsTableViewCell.reuseIdentifier)
        
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        if !gotProfile {
            self.viewModel = ProfileViewModel()
            runOnBackgroundThread {
                NetworkRequesterMock().getUser { user in
                    self.viewModel?.profile = user.profile
                    self.user? = user
                    self.viewModel?.user = user
                    self.tableView.reloadData()
                }
           }
        }
//        else {
//        print("lat in edit is \(self.viewModel?.profile?.lat)")
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
       
    }
    
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileSections.allCases[section] {
        case .userPhotos:
            return 1
        case .userVice:
            return 1
        case .userTable:
            return 1
        case .userPersonality:
            return 1
        case .userPriorities:
            return 1
        case .userFamilyPlans:
            return 1
        case .userQuestions:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("lat in edit is \(self.viewModel?.profile?.lat)")
        switch ProfileSections.allCases[indexPath.section] {
        case .userTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableTableViewCell.reuseIdentifier, for: indexPath) as? UserTableTableViewCell
            cell?.selectionStyle = .none
            if let details = viewModel?.profile?.personalDetails {
                cell?.initialize(personalDetails: details)
                cell?.viewController = self
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
            guard let vices = viewModel?.profile?.vices, let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceTableViewCell.reuseIdentifier, for: indexPath) as? MultipleChoiceTableViewCell else { return UITableViewCell()}
            cell.viewController = self
            cell.profile = self.viewModel?.profile
            cell.initialize(questions: vices)
            return cell
        case .userFamilyPlans:
            guard let familyPlans = viewModel?.profile?.familyPlans, let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceTableViewCell.newreuseIdentifier, for: indexPath) as? MultipleChoiceTableViewCell else { return UITableViewCell()}
            cell.viewController = self
            cell.profile = self.viewModel?.profile
            cell.viewModel = self.viewModel
            cell.delegate = self
            cell.initialize(questions: familyPlans)
            return cell
        case .userQuestions:
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.reuseIdentifier, for: indexPath) as? QuestionsTableViewCell
            cell?.viewController = self
            cell?.profile = viewModel?.profile
            if let vices = viewModel?.profile?.freeResponse {
                cell?.initialize(freeResponse: vices)
            }
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ProfileSections.allCases[indexPath.section] {
        case .userTable:
           return 400
        case .userVice:
           return 160
        case .userPhotos:
           return 225
        case .userPersonality:
           return 320
        case .userPriorities:
           return 195
        case .userFamilyPlans:
            return 160
        case .userQuestions:
           return 250
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return ProfileSections.allCases.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           switch ProfileSections.allCases[section] {
           case .userTable, .userVice,.userPhotos, .userPersonality, .userPriorities, .userFamilyPlans, .userQuestions:
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
