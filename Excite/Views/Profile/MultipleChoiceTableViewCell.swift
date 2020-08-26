//
//  MultipleChoiceTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/23/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class MultipleChoiceTableViewCell: UITableViewCell {
    static var reuseIdentifier = "MultipleChoiceTableViewCell"
        var tableView = UITableView()
        var questions: [MultipleChoiceAnswer]?
          
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        func initialize(questions: [MultipleChoiceAnswer]) {
            self.questions = questions
            self.addSubview(tableView)
            self.tableView.snp.makeConstraints { (make) in
                make.width.height.equalToSuperview()
                make.top.equalTo(5)
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .singleLine
            tableView.register(MultipleChoiceCellTableViewCell.self, forCellReuseIdentifier: MultipleChoiceCellTableViewCell.reuseIdentifier)
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

extension MultipleChoiceTableViewCell: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceCellTableViewCell.reuseIdentifier) as? MultipleChoiceCellTableViewCell
          cell?.selectionStyle = .none
        if let question = questions?[indexPath.row] {
              cell?.initialize(question: question)
          }
          return cell ?? UITableViewCell()
      }
    
     
}
