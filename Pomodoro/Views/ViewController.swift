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
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var dataReceived: String? {
            willSet {
                minutesLabel.text = newValue
            }
        }
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1800
  
    @IBAction func SelectSessionTypeButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Select Session Type", message: "Choose the type of session you wish to begin.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Work", style: .default, handler: { _ in
         //   print(workTime)
        }))
        
        alert.addAction(UIAlertAction(title: "Short Break", style: .default, handler: { _ in
            //print(shortBreakTime)
        }))
        
        alert.addAction(UIAlertAction(title: "Long Break", style: .default, handler: { _ in
            //print(longBreakTime)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button selected")
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        
        performSegue(withIdentifier: K.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueIdentifier {
            let destination = segue.destination as? SettingsViewController
        }
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        
        if let source = sender.source as? SettingsViewController {
            dataReceived = source.workTimeLabel.text
        }
               // minutesLabel.text = source.workTimeLabel.text
            
        }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.darkGray, for: .normal)
            startButton.backgroundColor = UIColor.lightGray
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.white, for: .normal)
            startButton.backgroundColor = UIColor(named: "Indigo")
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor(named: "Indigo")
        timer.invalidate()
        time = 1800
        isTimerStarted = false
        minutesLabel.text = "30"
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        //MARK fix: when time < 1
        time -= 1
        minutesLabel.text = formatTime()
    }
    
    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i", minutes)
    }
    
    
}

