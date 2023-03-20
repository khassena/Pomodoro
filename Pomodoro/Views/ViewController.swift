//
//  ViewController.swift
//  Pomodoro
//
//  Created by Daiana koishebayeva on 24.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var SelectSessionTypeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //SelectSessionTypeButton
    }

  
    @IBAction func SelectSessionTypeButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Select Session Type", message: "Choose the type of session you wish to begin.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Work", style: .default, handler: { _ in
            print("Work button selected")
        }))
        
        alert.addAction(UIAlertAction(title: "Short Break", style: .default, handler: { _ in
            print("Short Break button selected")
        }))
        
        alert.addAction(UIAlertAction(title: "Long Break", style: .default, handler: { _ in
            print("Long Break button selected")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button selected")
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        
        performSegue(withIdentifier: K.segueIdentifier, sender: self)
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        if sender.identifier == K.segueIdentifier {
            guard let source = sender.source as? SettingsViewController else { return }
                minutesLabel.text = source.workTimeLabel.text
            }
        }
    
}

