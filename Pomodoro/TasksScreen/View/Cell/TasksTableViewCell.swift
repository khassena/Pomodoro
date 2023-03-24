//
//  TasksTableViewCell.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    static let cell = "tasksCell"
    
    @IBOutlet weak var taskLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemIndigo
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        taskLabel.backgroundColor = .red
        taskLabel.layer.cornerRadius = 10
    }
}
