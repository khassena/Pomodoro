//
//  TasksModel.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import Foundation

enum TasksModel: Equatable {
    case pinned(Data)
    case pending(Data)
    case completed(Data)
    
    struct Data: Equatable {
        var task: String
        var id: String
        
        init(task: String, id: String = UUID().uuidString) {
            self.task = task
            self.id = id
        }
    }
    
    static func == (lhs: TasksModel, rhs: TasksModel) -> Bool {
        switch (lhs, rhs) {
        case let (.pinned(leftData), .pinned(rightData)):
            return leftData == rightData
        case let (.pending(leftData), .pending(rightData)):
            return leftData == rightData
        case let (.completed(leftData), .completed(rightData)):
            return leftData == rightData
        default: return false
        }
    }
}
