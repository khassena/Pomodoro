//
//  TasksModel.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import Foundation

enum TasksModel {
    case initial
    case pinned(Data)
    case pending(Data)
    case completed(Data)
    
    struct Data {
        var task: String
    }
}
