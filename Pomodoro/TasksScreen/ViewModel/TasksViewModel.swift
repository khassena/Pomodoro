//
//  ViewModel.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import Foundation
import RealmSwift

protocol TasksViewModelProtocol {
    
    var tasks: [String: [TasksModel]] { get set }
    var tasksCount: Int { get }
    
    var didFetchData: (([TasksModel]) -> Void)? { get set }
    var addedToDatabase: (() -> Void)? { get set }
    var changedPinnedTask: ((TasksModel, IndexPath) -> Void)? { get set }
    var changedCompletedTask: ((Int, Int, Int) -> Void)? { get set }
    var removedFromDatabase: (() -> Void)? { get set }
    
    func fetchFromDatabase()
    func addToDatabase(_ task: TasksModel)
    func changeTaskPinned(_ task: TasksModel, _ indexPath: IndexPath)
    func changeTaskCompleted(_ task: TasksModel, _ indexPath: IndexPath)
    func removeFromDatabase(_ task: TasksModel)
    func removeAllDB()
}

class TasksViewModel: TasksViewModelProtocol {
    
    var storageService: StorageServiceProtocol?
    var addedToDatabase: (() -> Void)?
    var didFetchData: (([TasksModel]) -> Void)?
    var changedPinnedTask: ((TasksModel, IndexPath) -> Void)?
    var changedCompletedTask: ((Int, Int, Int) -> Void)?
    var removedFromDatabase: (() -> Void)?
    
    var tasks: [String: [TasksModel]] = [:]
    var tasksCount: Int = 0
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
        fetchFromDatabase()
    }
    
    func fetchFromDatabase() {
        guard let data = storageService?.fetchFromDatabase() else { return }
        tasks["firstSection"] = []
        tasks["secondSection"] = []
        tasksCount = data.count
        for task in data {
            switch task {
            case .pending(let model):
                tasks["firstSection"]?.insert(.pending(model), at: 0)
            case .completed(let model):
                tasks["secondSection"]?.insert(.completed(model), at: 0)
            case .pinned(let model):
                tasks["firstSection"]?.insert(.pinned(model), at: 0)
            }
        }
        
//        didFetchData?(data)
    }
    
    func addToDatabase(_ task: TasksModel) {
        storageService?.addToDatabase(task)
        fetchFromDatabase()
        addedToDatabase?()
    }
    
    func changeTaskPinned(_ task: TasksModel, _ indexPath: IndexPath) {
        var newTask: TasksModel?
        switch task {
        case .pending(let data):
            newTask = .pinned(data)
        case .pinned(let data):
            newTask = .pending(data)
        default: break
        }
        
        storageService?.changeTaskPinned(newTask, indexPath.row)
        fetchFromDatabase()
        guard let newTask = self.tasks["firstSection"]?[indexPath.row] else { return }
        changedPinnedTask?(newTask, indexPath)
    }
    
    func changeTaskCompleted(_ task: TasksModel, _ indexPath: IndexPath) {
        var newTask: TasksModel?
        switch task {
        case .pending(let data):
            newTask = .completed(data)
        case .completed(let data):
            newTask = .pending(data)
        case .pinned(let data):
            newTask = .completed(data)
        }
        
        storageService?.changeTaskCompleted(newTask, indexPath.row)
        fetchFromDatabase()
        let key = indexPath.section == .zero ? "secondSection" : "firstSection"
        guard let newTaskR = tasks[key]?.firstIndex(where: { $0 == newTask }) else { return }
        
        changedCompletedTask?(newTaskR, indexPath.row, indexPath.section)
        
    }
    
    func removeFromDatabase(_ task: TasksModel) {
        storageService?.removeFromDatabase(task)
        removedFromDatabase?()
    }
    
    func removeAllDB() {
        storageService?.removeAll()
    }
}


