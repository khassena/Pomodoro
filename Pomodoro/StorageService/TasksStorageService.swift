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
    func changeTaskPinned(_ task: TasksModel?)
    func changeTaskCompleted(_ task: TasksModel?)
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
            data.id = model.id
            data.pending = true
        case .completed(let model):
            data.task = model.task
            data.id = model.id
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
            if item.completed {
                storedData.append(.completed(TasksModel.Data(task: item.task, id: item.id)))
            } else if item.pinned {
                storedData.append(.pinned(TasksModel.Data(task: item.task, id: item.id)))
            } else if item.pending {
                storedData.append(.pending(TasksModel.Data(task: item.task, id: item.id)))
            }
        }
        return storedData
    }
    
    func changeTaskPinned(_ task: TasksModel?) {
        guard let realm = realm, task != nil else { return }
        let realmObjects = realm.objects(TasksStorageModel.self)
        let prevPinnedObj = realmObjects.filter { $0.pinned == true }.first
        var data = TasksStorageModel()
        var pinned = false
        
        switch task {
        case .pinned(let model):
            data = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
            pinned = true
        case .pending(let model):
            data = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
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
    
    func changeTaskCompleted(_ task: TasksModel?) {
        guard let realm = realm, task != nil else { return }
        let realmObjects = realm.objects(TasksStorageModel.self)
        var data = TasksStorageModel()
        var completed = false
    
        switch task {
        case .pending(let model):
            data = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
            completed = false
        case .completed(let model):
            data = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
            completed = true
        default: break
        }
        
        do {
            try realm.write {
                data.pinned = false
                data.completed = completed
            }
        } catch {
            print(error)
        }
    }
    
    func removeFromDatabase(_ task: TasksModel) {
        guard let realm = realm else { return }
        let realmObjects = realm.objects(TasksStorageModel.self)
        var deleteObject = TasksStorageModel()
        
        switch task {
        case .pending(let model):
            deleteObject = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
        case .completed(let model):
            deleteObject = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
        case .pinned(let model):
            deleteObject = realmObjects.filter({ $0.id == model.id }).first ?? TasksStorageModel()
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
