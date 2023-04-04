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
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Call the function to draw the circular timer
        drawBackLayer()
        
        //MARK: This condition is needed so that the reset button is not displayed when the application is opened
        if !isTimerStarted
        {
            resetButton.isEnabled = true
            resetButton.alpha = 0.0
        }
        
        startButton.layer.cornerRadius = 0.15 * startButton.bounds.size.width
        startButton.clipsToBounds = true
        
        settingsButton.layer.cornerRadius = 0.2 * startButton.bounds.size.width
        settingsButton.clipsToBounds = true
        
        taskButton.layer.cornerRadius = 0.2 * startButton.bounds.size.width
        taskButton.clipsToBounds = true
        
    }

    var dataReceived: String? {
            willSet {
                minutesLabel.text = newValue
            }
        }
    
    //Create variables for the individual parts of the circular timer
    let foreProgressLayer = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    //Variables for better control of timer settings
    var timer = Timer()
    var isAnimationStarted = false
    var isTimerStarted = false
    var time = 5
  
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
    
    
    //MARK: What happens when the start button is pressed:
    
    @IBAction func startButtonTapped(_ sender: Any) {
        //Hiding and turn off the reset button
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        
        if !isTimerStarted {
            drawForeLayer() //draw the painted area of the circle
            startResumeAnimation() //start the animation of coloring
            startTimer() //start the timer countdown
            isTimerStarted = true
            
            //change the button (its style and allow to pause)
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.darkGray, for: .normal)
            startButton.backgroundColor = UIColor.lightGray
            
        } else //Otherwise we give the opportunity to restore the timer countdown and its drawing on the circle
        {
            pauseAnimation()
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.white, for: .normal)
            startButton.backgroundColor = UIColor(named: "Indigo")
        }
    }
    
    //MARK: What happens when the reset button is pressed:
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        stopAnimation() //Hide animation
        //Hide button
        resetButton.isEnabled = true
        resetButton.alpha = 0.0
        //changing the style and the start button
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor(named: "Indigo")
        timer.invalidate()
        time = 5 //for test duration is equal only to 5 seconds
        isTimerStarted = false //disabling the timer
        minutesLabel.text = "30" //also for testing the app our duration of timer so narrowly
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() //Timer update function. When it finishes, it brings it back to the initial state
    {
        if time < 1 {
            resetButton.isEnabled = false
            resetButton.alpha = 0.5
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor.gray, for: .normal)
            timer.invalidate()
            time = 5
            isTimerStarted = false
            minutesLabel.text = "30"
        } else {
            time -= 1
            minutesLabel.text = formatTime()
        }
    }
    
    //So that we can display only the minutes, we convert the format of the numbers on the screen (from seconds to minutes).
    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i", minutes)
    }
    //In the future, we will create a separate function to simplify the work (we will enter the minute equivalent at once)
    
    
    //MARK: this code of background layer of timer circle.
    func drawBackLayer() {
        backProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        backProgressLayer.strokeColor = UIColor.gray.cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 15
        view.layer.addSublayer(backProgressLayer)
    }
    //MARK: this code of foreground layer of timer circle.
    func drawForeLayer() {
        foreProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        foreProgressLayer.strokeColor = UIColor.white.cgColor
        foreProgressLayer.fillColor = UIColor.clear.cgColor
        foreProgressLayer.lineWidth = 15
        view.layer.addSublayer(foreProgressLayer)
    }
    
    //MARK: Next: "Circular timer functions"
    /*
     Nothing special and long to prescribe, the algorithm is the same. We just forbid the drawing of the circle further in the animation, then continue to draw it, then finish and hide. After the timer ends, the circle is completely filled. And we can start again by pressing the start button
     */
    
    func startResumeAnimation(){
        if !isAnimationStarted{
            startAnimation()
        } else {
            resumeAnimation()
        }
    }
    
    func startAnimation() {
        resetAnimation()
        foreProgressLayer.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval(time)
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        foreProgressLayer.add(animation, forKey: "strokeEnd")
        isAnimationStarted = true
    }
    
    func resetAnimation() {
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = 0.0
        foreProgressLayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation() {
        let pausedTime = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foreProgressLayer.speed = 0.0
        foreProgressLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = foreProgressLayer.timeOffset
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = 0.0
        let timeScincePaused = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        foreProgressLayer.beginTime = timeScincePaused
    }
    
    func stopAnimation(){
        foreProgressLayer.speed = 1.0
        foreProgressLayer.timeOffset = 0.0
        foreProgressLayer.beginTime = 0.0
        foreProgressLayer.strokeEnd = 0.0
        foreProgressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
}

//Extension for easy rendering of the timer from the middle
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

