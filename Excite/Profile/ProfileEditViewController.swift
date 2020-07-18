//
//  ProfileEditViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {
    var viewModel: ProfileViewModel?
    var tableView = UITableView()
    enum ProfileSections: String, CaseIterable {
        case userPhotos = "userPhotos"
        case userTable  = "table"
    }
     override func viewDidLoad() {
        self.viewModel = ProfileViewModel()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 28
        super.viewDidLoad()
        view.backgroundColor = .white
        print("SETUP")
        //setupUI()
        self.view.addSubview(tableView)
        tableView.register(ProfilePhotosCell.self, forCellReuseIdentifier: ProfilePhotosCell.reuseIdentifier)
        tableView.register(UserTableTableViewCell.self, forCellReuseIdentifier: UserTableTableViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            //make.centerX.equalToSuperview()
        }
        runOnBackgroundThread {
            NetworkRequesterMock().getProfile(completion: { (results) in
                switch results {
                case .success(let response):
                    print(response)
                    self.viewModel?.profile = response
                    runOnMainThread {
                        self.tableView.reloadData()
                    }
                default:
                    break
                }
            })
            NetworkRequesterMock().getQuestion(completion: { (results) in
                switch results {
                case .success(let response):
                   print(response)
                   self.viewModel?.questions = response
                //                       runOnMainThread {
                //                           self.tableView.reloadData()
                //                       }
                default:
                   break
                }
            })
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
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProfileSections.allCases[indexPath.section] {
        case .userTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableTableViewCell.reuseIdentifier, for: indexPath) as? UserTableTableViewCell
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.brown
            cell?.initialize()
            return cell ?? UITableViewCell()
        case .userPhotos:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotosCell.reuseIdentifier, for: indexPath) as? ProfilePhotosCell
           //cell?.backgroundColor = UIColor.cyan
            cell?.selectionStyle = .none
            if let photos = viewModel?.profile?.photos {
              //  print("size is \(photos.count)")
                 cell?.configure(photos: photos)
            }
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           switch ProfileSections.allCases[indexPath.section] {
           case .userTable:
               return 220
           case .userPhotos:
               return 220
           }
       }
    func numberOfSections(in tableView: UITableView) -> Int {
       return ProfileSections.allCases.count
   }
}
