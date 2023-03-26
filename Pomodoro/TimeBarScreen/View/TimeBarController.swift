//
//  TimeBarController.swift
//  Pomodoro
//
//  Created by Dariya Gecher on 24.03.2023.
//

import UIKit

class TimeBarController: UIViewController {
    
    let workLabel: UILabel = {
        let label = UILabel()
        label.text = "Yor pinned tasks will come here too!"
        return label
    }()
    
    let startButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setConstraints()
    }
}

extension TimeBarController {
    
    func setConstraints() {
        
        view.addSubview(workLabel)
        NSLayoutConstraint.activate([
            workLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            workLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

