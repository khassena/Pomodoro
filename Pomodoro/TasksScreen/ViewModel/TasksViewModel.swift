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
    
    var didFetchData: (([TasksModel]) -> Void)? { get set }
    var addedToDatabase: (() -> Void)? { get set }
    var changedPinnedTask: (() -> Void)? { get set }
    var removedFromDatabase: (() -> Void)? { get set }
    
    func fetchFromDatabase()
    func addToDatabase(_ task: TasksModel)
    func changeTaskPinned(_ task: TasksModel)
    func removeFromDatabase(_ task: TasksModel)
    func removeAllDB()
}

class TasksViewModel: TasksViewModelProtocol {
    
    var storageService: StorageServiceProtocol?
    var addedToDatabase: (() -> Void)?
    var didFetchData: (([TasksModel]) -> Void)?
    var changedPinnedTask: (() -> Void)?
    var removedFromDatabase: (() -> Void)?
    
    var tasks: [String: [TasksModel]] = [:]
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
        fetchFromDatabase()
    }
    
    func fetchFromDatabase() {
        guard let data = storageService?.fetchFromDatabase() else { return }
        tasks["firstSection"] = []
        tasks["secondSection"] = []
        for task in data {
            switch task {
            case .pending(let model):
                print(model)
                tasks["firstSection"]?.insert(.pending(model), at: 0)
            case .completed(let model):
                tasks["secondSection"]?.insert(.completed(model), at: 0)
            default: break
            }
        }
        
        didFetchData?(data)
    }
    
    func addToDatabase(_ task: TasksModel) {
        storageService?.addToDatabase(task)
        addedToDatabase?()
    }
    
    func changeTaskPinned(_ task: TasksModel) {
        storageService?.changeTaskPinned(task)
        changedPinnedTask?()
    }
    
    func removeFromDatabase(_ task: TasksModel) {
        storageService?.removeFromDatabase(task)
        removedFromDatabase?()
    }
    
    func removeAllDB() {
        storageService?.removeAll()
    }
}


