//
//  TaskStoreModel.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 27.03.2023.
//

import Foundation
import RealmSwift

class TasksStorageModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var task: String = ""
    @objc dynamic var pinned: Bool = false
    @objc dynamic var pending: Bool = false
    @objc dynamic var completed: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
