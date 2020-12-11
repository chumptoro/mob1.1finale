//
//  PlayViewController.swift
//  ZeColorGame
//
//  Created by Mark Pham on 12/7/20.
//

//extension to convert a HTML name string into a UIColor
//code credit: https://www.hackingwithswift.com/
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

    public convenience init?(name: String) {
        let allColors = [
            "black": "#000000FF",
            "blue": "#0000FFFF",
            "brown": "#A52A2AFF",
            "crimson": "#DC143CFF",
            "cyan": "#00FFFFFF",
            "gray": "#808080FF",
            "green": "#008000FF",
            "indigo": "#4B0082FF",
            "lavender": "#E6E6FAFF",
            "lavenderblush": "#FFF0F5FF",
            "navy": "#000080FF",
            "orange": "#FFA500FF",
            "orangered": "#FF4500FF",
            "purple": "#800080FF",
            "red": "#FF0000FF",
            "skyblue": "#87CEEBFF",
            "steelblue": "#4682B4FF",
            "tan": "#D2B48CFF",
            "teal": "#008080FF",
            "yellow": "#FFFF00FF",
        ]

        let cleanedName = name.replacingOccurrences(of: " ", with: "").lowercased()

        if let hexString = allColors[cleanedName] {
            self.init(hexString: hexString)
        } else {
            return nil
        }
    }
}

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    
    @IBOutlet weak var textWithColor: UILabel!
    @IBOutlet weak var textinBlack: UILabel!
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
        
        textWithColor.layer.borderColor = UIColor.darkGray.cgColor
        textWithColor.layer.borderWidth = 1.0
        textinBlack.layer.borderColor = UIColor.darkGray.cgColor
        textinBlack.layer.borderWidth = 1.0
        
        tapInt = 0
        scoreLabel.text = String(tapInt)
        
        startInt = 3
        button.setTitle(String(startInt), for: .normal)
        button.isEnabled = false
        yesButton.isEnabled = false
        noButton.isEnabled = false
        timeLabel.textColor = UIColor(name: "blue")
        
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
        
        //present the first set of cards
        textWithColor.text = "Black"
        textWithColor.textColor = UIColor(name: "teal")
        textinBlack.text = "Blue"
        
        
//        while gameInt >= 0 {
//            var number = Int.random(in: 1...2)
//            if number == 1 {
//                textWithColor.layer.borderColor = UIColor.red.cgColor
//            }
//            else {
//                textWithColor.layer.borderColor = UIColor.blue.cgColor
//            }
//        }
        
        if gameInt == 0 {
            timeLabel.text = String("0")
            yesButton.isEnabled = false
            noButton.isEnabled = false
            gameTimer.invalidate()
            
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(PlayViewController.end), userInfo: nil, repeats: false)
            
        }
    }
    
    @objc func end() {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
//        self.present(vc, animated: false, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
}
