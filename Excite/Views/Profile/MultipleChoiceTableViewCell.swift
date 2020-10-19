//
//  MultipleChoiceTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/23/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol MultipleChoiceTableViewCellDelegate: class {
    func didRequestEditChoiceViewController(viewController: EditChoiceViewController)
    func familyPlanEdited( questions: [MultipleChoiceAnswer])
    func vicesEdited( questions: [MultipleChoiceAnswer])
}

class MultipleChoiceTableViewCell: UITableViewCell {
    static var reuseIdentifier = "MultipleChoiceTableViewCell"
    static var newreuseIdentifier = "MultipleChoiceTableViewCell2"
    var identifier: String?
    var tableView = UITableView()
    public var questions: [MultipleChoiceAnswer]?
    
    weak var delegate: MultipleChoiceTableViewCellDelegate?

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
        tableView.separatorStyle = .none
        tableView.register(MultipleChoiceCellTableViewCell.self, forCellReuseIdentifier: MultipleChoiceCellTableViewCell.reuseIdentifier)
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        tableView.removeFromSuperview()
        tableView.reloadData()
    }
}

extension MultipleChoiceTableViewCell: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let question = questions?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: MultipleChoiceCellTableViewCell.reuseIdentifier) as? MultipleChoiceCellTableViewCell else { return UITableViewCell() }
            cell.initialize(question: question)
          return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditChoiceViewController(model: EditChoiceViewModel(
            choices: questions?[indexPath.row].answerChoices,
            index: indexPath.row,
            questions: questions,
            identifier: identifier,
            selectedAnswer: questions?[indexPath.row].answer))
        controller.delegate = self
        delegate?.didRequestEditChoiceViewController(viewController: controller)
    }

}

extension MultipleChoiceTableViewCell: EditChoiceViewControllerDelegate {
   
    func mcEdited( questions: [MultipleChoiceAnswer], identifier: String) {
        if identifier == "vices" {
            delegate?.vicesEdited( questions: questions)
        } else {
            delegate?.familyPlanEdited( questions: questions)
        }
    }
}
