//
//  StorageService.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 28.03.2023.
//

import Foundation
import RealmSwift

protocol StorageServiceProtocol {
    func addToDatabase(_ task: TasksModel)
    func fetchFromDatabase() -> [TasksModel]?
    func changeTaskPinned(_ task: TasksModel?, _ index: Int)
    func removeFromDatabase(_ task: TasksModel)
    func removeAll()
}

class StorageService: StorageServiceProtocol {
    
    var realm = try? Realm()
    var storedData: [TasksModel] = []
    
    func addToDatabase(_ task: TasksModel) {
        let data = TasksStorageModel()
        
        switch task {
        case .pending(let model):
            data.task = model.task
            data.pending = true
        case .completed(let model):
            data.task = model.task
            data.completed = true
        default: break
        }
        
        do {
            try realm?.write {
                realm?.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchFromDatabase() -> [TasksModel]? {
        guard let realm = realm else { return [] }
        storedData = []
        for item in realm.objects(TasksStorageModel.self) {
            if item.pinned {
                storedData.append(.pinned(TasksModel.Data(task: item.task)))
            } else if item.pending {
                storedData.append(.pending(TasksModel.Data(task: item.task)))
            } else {
                storedData.append(.completed(TasksModel.Data(task: item.task)))
            }
        }
        return storedData
    }
    
    func changeTaskPinned(_ task: TasksModel?, _ index: Int) {
        guard let realm = realm, task != nil else { return }
        let realmObjects = realm.objects(TasksStorageModel.self)
        let prevPinnedObj = realmObjects.filter { $0.pinned == true }.first
        var data = TasksStorageModel()
        var pinned = false
        
        switch task {
        case .pinned(_):
            data = realmObjects.reversed()[index]
            pinned = true
        case .pending(_):
            data = realmObjects.reversed()[index]
            pinned = false
        default: break
        }
        
        do {
            try realm.write {
                prevPinnedObj?.pinned = !pinned
                data.pinned = pinned
            }
        } catch {
            print(error)
        }
    }
    
    func removeFromDatabase(_ task: TasksModel) {
        guard let realm = realm else { return }
        var deleteObject = TasksStorageModel()
        
        switch task {
        case .pinned(let model):
            deleteObject = realm.objects(TasksStorageModel.self).filter({ model.task == $0.task }).first ?? TasksStorageModel()
        default: break
        }
        
        do{
            try realm.write({
                realm.delete(deleteObject)
            })
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func removeAll() {
        guard let realm = realm else { return }
        do{
            try realm.write({
                realm.deleteAll()
            })
        }catch let error {
            print(error.localizedDescription)
        }
    }
}
