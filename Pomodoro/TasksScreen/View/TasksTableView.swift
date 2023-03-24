//
//  TasksTableView.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import UIKit

class TasksTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
        register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.cell)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        sectionFooterHeight = 0
        backgroundColor = .white
        sectionHeaderTopPadding = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
