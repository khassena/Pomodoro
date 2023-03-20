//
//  SettingsViewController.swift
//  Pomodoro
//
//  Created by Daiana koishebayeva on 24.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //let defaults = UserDefaults.standard

    @IBOutlet weak var workTimeStepper: UIStepper!
    @IBOutlet weak var workTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(workTimeStepper.value)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        workTimeLabel.text = String(format: "%.0f", workTimeStepper.value)
        //defaults.set(workTimeLabel.text, forKey: K.workTime)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destVC = segue.destination as? ViewController
//        destVC?.minutesLabel.text = workTimeLabel.text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
