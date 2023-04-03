//
//  TasksViewController.swift
//  Pomodoro
//
//  Created by Amanzhan Zharkynuly on 23.03.2023.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var taskTableView: TasksTableView!
    
    
    // MARK: Properties
    var viewModel: TasksViewModelProtocol!
    private var storageService: StorageServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageService = StorageService()
        viewModel = TasksViewModel(storageService: storageService)
        bindToViewModel()
        taskTableView.sectionHeaderTopPadding = 10
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    

    @IBAction func addNewAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your task",
                                                message: "",
                                                preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Готово",
                                   style: .default) { action in
            guard let text = alert.textFields?.first?.text else { return }
            self.viewModel.addToDatabase(.pending(TasksModel.Data(task: text)))
        }
        let actionCancel = UIAlertAction(title: "Отмена",
                                   style: .default) { action in
            alert.dismiss(animated: true)
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    


}

extension TasksViewController {
    private func bindToViewModel() {
        viewModel.addedToDatabase = {
            let newIndexPath = IndexPath(row: 0, section: 0)
            self.taskTableView.beginUpdates()
            self.taskTableView.insertRows(at: [newIndexPath], with: .automatic)
            self.taskTableView.endUpdates()
        }
        
//        viewModel.didFetchData = { [weak self] data in
//            print(data)
//
//        }
        
        viewModel.changedPinnedTask = { [weak self] (task, indexPath) in
            let cell = self?.taskTableView.cellForRow(at: indexPath) as? TasksTableViewCell
            cell?.configCell(task)
            self?.taskTableView.reloadData()
        }
    }
}

extension TasksViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return viewModel?.tasks["firstSection"]?.count ?? 0
        } else {
            return viewModel?.tasks["secondSection"]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == .zero {
            return "Pending Tasks"
        } else {
            return "Completed Tasks"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.cell, for: indexPath) as? TasksTableViewCell,
              let task = indexPath.section == .zero ? viewModel?.tasks["firstSection"]?[indexPath.row] : viewModel?.tasks["secondSection"]?[indexPath.row] else { return UITableViewCell()
        }
        cell.configCell(task)
        cell.selectionStyle = .none
        return cell
    }
    
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = viewModel?.tasks["firstSection"]?[indexPath.row] else { return }
        viewModel.changeTaskPinned(task, indexPath)
    }
}
