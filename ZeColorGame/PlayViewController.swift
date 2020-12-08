//
//  PlayViewController.swift
//  ZeColorGame
//
//  Created by Mark Pham on 12/7/20.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var tapInt = 0
    
    var startInt = 3
    var startTimer = Timer()
    
    var gameInt = 5
    var gameTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        // Do any additional setup after loading the view.
        
        tapInt = 0
        scoreLabel.text = String(tapInt)
        
        startInt = 3
        button.setTitle(String(startInt), for: .normal)
        button.isEnabled = false
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        gameInt = 5
        timeLabel.text = String(gameInt)
        
        //trigger the timer
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlayViewController.startGameTimer), userInfo: nil, repeats: true)
    }
    

    @IBAction func tapMeButton(_ sender: Any) {
        tapInt += 1
        scoreLabel.text = String(tapInt)
    }
    
    @objc func startGameTimer() {
        startInt -= 1
        button.setTitle(String(startInt), for: .normal)
        
        if startInt == 0 {
            startTimer.invalidate()
            button.setTitle("Go!", for: .normal)
            yesButton.isEnabled = true
            noButton.isEnabled = true
            
            //start 60 seconds timer count down for the game itself
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlayViewController.game), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func game() {
        gameInt -= 1
        timeLabel.text = String(gameInt)
        
         
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
