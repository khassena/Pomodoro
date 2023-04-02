//
//  TasksTableViewCell.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    static let cell = "tasksCell"
    @IBOutlet weak var pinIcon: UIImageView!
    @IBOutlet weak var taskLabel: UILabel! {
        didSet {
            taskLabel.layer.cornerRadius = 10
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    func configCell(_ task: TasksModel) {
       
        switch task {
        case .pinned(let model):
            taskLabel.text = model.task
            taskLabel.textColor = .white
            pinIcon.isHidden = false
            taskLabel.backgroundColor = .systemIndigo
        case .pending(let model):
            taskLabel.text = model.task
            pinIcon.isHidden = true
        case .completed(let model):
            taskLabel.text = model.task
            pinIcon.isHidden = true
            taskLabel.backgroundColor = .darkGray
        default: break
        }
        
    }
}
