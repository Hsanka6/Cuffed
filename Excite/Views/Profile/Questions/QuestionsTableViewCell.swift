//
//  QuestionsTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/26/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {
    static var reuseIdentifier = "QuestionsTableViewCell"
    var tableView = UITableView()
    var freeResponse: [FreeResponse]?
    public var profile: Profile?
    
    public var viewController: UIViewController?
      

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initialize(freeResponse: [FreeResponse]) {
       
        
        self.freeResponse = freeResponse
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.top.equalTo(5)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
       
        tableView.register(QuestionsDetailTableViewCell.self, forCellReuseIdentifier: QuestionsDetailTableViewCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
        

    // Configure the view for the selected state
    }

}

extension QuestionsTableViewCell: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeResponse?.count ?? 0
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsDetailTableViewCell.reuseIdentifier) as? QuestionsDetailTableViewCell
          cell?.selectionStyle = .none
        if let free = freeResponse?[indexPath.row] {
              cell?.initialize(freeResponse: free)
          }
          return cell ?? UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let newViewController = BrowseQuestionsViewController()
        newViewController.profile = profile
        newViewController.index = indexPath.row
        self.viewController?.navigationController?.pushViewController(newViewController, animated: true)
    
    }
     
}
