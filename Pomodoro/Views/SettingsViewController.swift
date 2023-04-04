//
//  SettingsViewController.swift
//  Pomodoro
//
//  Created by Daiana koishebayeva on 24.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var workTimeLabel: UILabel!
    
    @IBOutlet weak var shortBreakTimeLabel: UILabel!
    
    @IBOutlet weak var longBreakTimeLabel: UILabel!
    @IBOutlet weak var plusWorkButton: UIButton!
    @IBOutlet weak var minusWorkButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    var workTime: Int = 30
    var shortBreakTime: Int = 5
    var longBreakTime: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workTimeLabel.text = UserDefaults.standard.string(forKey: "Work Time")
        shortBreakTimeLabel.text = UserDefaults.standard.string(forKey: "Short Break Time")
        longBreakTimeLabel.text = UserDefaults.standard.string(forKey: "Long Break Time")
        
        //workTimeLabel.text = String(workTime)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.set(workTime, forKey: "Work Time")
        UserDefaults.standard.set(shortBreakTime, forKey: "Short Break Time")
        UserDefaults.standard.set(longBreakTime, forKey: "Long Break Time")
    }
    
    
    @IBAction func increaseWorkTime(_ sender: UIButton) {
        if workTime < 99 {
            workTime += 1
        }
        
        workTimeLabel.text = String(workTime)
    }
    
    @IBAction func decreaseWorkTime(_ sender: UIButton) {
        if workTime != 0 {
            workTime -= 1
        }
        workTimeLabel.text = String(workTime)
    }
    
    @IBAction func increaseShortBreakTime(_ sender: UIButton) {
        if shortBreakTime < 99 {
            shortBreakTime += 1
        }
        shortBreakTimeLabel.text = String(shortBreakTime)
    }
    
    @IBAction func decreaseShortBreakTime(_ sender: UIButton) {
        if shortBreakTime != 0 {
            shortBreakTime -= 1
        }
        shortBreakTimeLabel.text = String(shortBreakTime)
    }
    
    @IBAction func increaseLongBreakTime(_ sender: UIButton) {
        if longBreakTime < 99 {
            longBreakTime += 1
        }
        longBreakTimeLabel.text = String(longBreakTime)
    }
    
    @IBAction func decreaseLongBreakTime(_ sender: UIButton) {
        if longBreakTime != 0 {
            longBreakTime -= 1
        }
        longBreakTimeLabel.text = String(longBreakTime)
    }
    

    
}
