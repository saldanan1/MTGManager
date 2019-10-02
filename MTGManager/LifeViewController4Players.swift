//
//  LifeViewController4Players.swift
//  MTGManager
//
//  Created by Noah Saldaña on 8/28/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class LifeViewController4Players: UIViewController{
    var lifeTotalT: Int!
    
    var lifeTotalP1: Int!
    var lifeTotalP2: Int!
    var lifeTotalP3: Int!
    var lifeTotalP4: Int!
    
    var textColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    var dividerColor: UIColor! = .gray
    var backgroundColor: UIColor! = .darkGray
    var fontSize: CGFloat! = 75.0
    var viewStayOn: Bool!
    var playerNameColor: UIColor! = .black
    
    var playerOneName: String! = ""
    var playerTwoName: String! = ""
    var playerThreeName: String! = ""
    var playerFourName: String! = ""
    @IBOutlet weak var plusTopLeft: UILabel!
    @IBOutlet weak var minusTopLeft: UILabel!
    @IBOutlet weak var plusBottomLeft: UILabel!
    @IBOutlet weak var minusBottomLeft: UILabel!
    @IBOutlet weak var plusTopRight: UILabel!
    @IBOutlet weak var minusTopRight: UILabel!
    @IBOutlet weak var plusBottomRight: UILabel!
    @IBOutlet weak var minusBottomRight: UILabel!
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    @IBOutlet weak var Player4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageLifeTotals()
        manageLifeChangeButtons()
        refresh()
        loadDividers()
        loadUserDefaults()
        handlePlusMinus()
    }
    override func viewWillAppear(_ animated: Bool) {
        refresh()
        if (viewStayOn == true){
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
    func loadUserDefaults(){
        backgroundColor = UserDefaults.standard.color(forKey: "previewView")
        dividerColor = UserDefaults.standard.color(forKey: "dividerColor")
        fontSize = CGFloat(UserDefaults.standard.integer(forKey: "fontSize"))
        textColor = UserDefaults.standard.color(forKey: "textColor")
        playerNameColor = UserDefaults.standard.color(forKey: "playerNameColor")
        
        Player1Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player2Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player3Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player4Label.textColor = UserDefaults.standard.color(forKey: "textColor")
    }
    func handlePlusMinus(){
        for case let text as UILabel in self.view.subviews{
            if (text.accessibilityIdentifier == "plusMinusButtons"){
                text.textColor = textColor
                text.font = UIFont(name:"HelveticaNeue-Bold", size: 45)
                text.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
                self.view.bringSubviewToFront(text)
            }
        }
        plusTopLeft.center.x = 7*(self.view.frame.width/24)//halfway between 1/4 and 1/3
        plusTopLeft.center.y = self.view.center.y - self.view.frame.height/8
        
        minusTopLeft.center.x = 7*(self.view.frame.width/24)
        minusTopLeft.center.y = self.view.frame.height/8
        
        plusBottomLeft.center.x = 7*(self.view.frame.width/24)
        plusBottomLeft.center.y = self.view.frame.height - self.view.frame.height/8
        
        minusBottomLeft.center.x = 7*(self.view.frame.width/24)
        minusBottomLeft.center.y = self.view.center.y + self.view.frame.height/8
        
        plusTopRight.center.x = self.view.frame.width - self.view.frame.width/4
        plusTopRight.center.y = self.view.frame.height/8
        
        minusTopRight.center.x = self.view.frame.width - self.view.frame.width/4
        minusTopRight.center.y = self.view.center.y - self.view.frame.height/8
        
        plusBottomRight.center.x = self.view.frame.width - (self.view.frame.width/4)
        plusBottomRight.center.y = self.view.center.y + self.view.frame.height/8
        
        minusBottomRight.center.x = self.view.frame.width - (self.view.frame.width/4)
        minusBottomRight.center.y = self.view.frame.height - self.view.frame.height/8
    }
    func refresh(){
        Player1Label.text = String(lifeTotalP1)
        Player2Label.text = String(lifeTotalP2)
        Player3Label.text = String(lifeTotalP3)
        Player4Label.text = String(lifeTotalP4)
        
        for case let button as UIButton in self.view.subviews {
            if (button.restorationIdentifier != "settings"){
                button.backgroundColor = backgroundColor
            }
            if (button.restorationIdentifier == "playerNameText"){
                button.setTitleColor(playerNameColor, for: .normal)
            }
        }
        for case let text as UILabel in self.view.subviews{
            if (text.restorationIdentifier != "someLabel" && text.accessibilityIdentifier != "plusMinusButtons"){
                text.textColor = textColor
                self.view.bringSubviewToFront(text)
                text.font = UIFont(name:"DevanagariSangamMN", size: fontSize)
                text.sizeToFit()
            }
        }
        for case let view as UIView in self.view.subviews{
            if (view.restorationIdentifier == "divider"){
                view.backgroundColor = dividerColor
            }
        }
    }
    func manageLifeChangeButtons(){
        //down tick = 0
        //up tick = 1
        
        //player 1 (right side, top life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 1")
        //player 1 (right side, top life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 1")
        
        //player 2 (right side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 2")
        //player 2 (right side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 2")
        
        //player 3 (left side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 3")
        //player 3 (left side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 3")
        
        //player 4 (left side, top life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 4")
        //player 4 (left side, top life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 4")
        
        //player 1 name label/button
        loadPlayerName(cgX: 0, cgY: 0, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerOneName, rotate90: true)
        
        //player 2 name label/button
        loadPlayerName(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerTwoName, rotate90: true)
        
        //player 3 name label/button
        loadPlayerName(cgX: view.frame.width - view.frame.width/9, cgY: 0, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerThreeName, rotate90: false)
        
        //player 4 name label/button
        loadPlayerName(cgX: view.frame.width - view.frame.width/9, cgY: view.frame.height/2, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerFourName, rotate90: false)
    }
    func loadPlayerName(cgX: CGFloat, cgY: CGFloat, cgWidth: CGFloat, cgHeight: CGFloat, playerName: String, rotate90: Bool){
        var widthToAdd: CGFloat = 0.0
        if (rotate90 == true){
            widthToAdd = cgWidth/4
        }
        else{
            widthToAdd = -cgWidth/4
        }
        
        let genericRect = CGRect(x: cgX + widthToAdd, y: cgY, width: cgWidth, height: cgHeight)
        let genericNameButton = UIButton(frame: genericRect)
        if (rotate90 == true){
            genericNameButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        }
        else{
            genericNameButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        }
        genericNameButton.restorationIdentifier = "playerNameText"
        genericNameButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
        genericNameButton.setTitleColor(.blue, for: .normal)
        genericNameButton.setTitle(playerName, for: .normal)
        genericNameButton.backgroundColor = dividerColor
        genericNameButton.sizeToFit()
        
        self.view.addSubview(genericNameButton)
    }
    @objc func lifeChangePress(sender: UIButton) {
//        UIView.transition(with: sender, duration: 0.05, options: .curveEaseInOut, animations: {
//            sender.backgroundColor = .black
//            sender.setTitle("", for: .normal)
//            sender.setTitleColor(.white, for: .normal)
//            sender.backgroundColor = self.backgroundColor
//            
//            self.view.bringSubviewToFront(self.Player1Label)
//            self.view.bringSubviewToFront(self.Player2Label)
//            self.view.bringSubviewToFront(self.Player3Label)
//            self.view.bringSubviewToFront(self.Player4Label)
//        })
        if (sender.tag == 1){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 += 1
            }
            else if (sender.restorationIdentifier == "Player 2"){
                lifeTotalP2 += 1
            }
            else if (sender.restorationIdentifier == "Player 3"){
                lifeTotalP3 += 1
            }
            else {
                lifeTotalP4 += 1
            }
        }
        else if (sender.tag == 0){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 -= 1
            }
            else if (sender.restorationIdentifier == "Player 2"){
                lifeTotalP2 -= 1
            }
            else if (sender.restorationIdentifier == "Player 3"){
                lifeTotalP3 -= 1
            }
            else {
                lifeTotalP4 -= 1
            }
        }
        refresh()
    }
    func loadChangeLifeTotalButtons
        (cgX: CGFloat, cgY: CGFloat, cgWidth: CGFloat, cgHeight: CGFloat, buttonName: Int, playerNumber: String){
        
        let genericRect = CGRect(x: cgX, y: cgY, width: cgWidth, height: cgHeight)
        
        let genericButton = UIButton(frame: genericRect)
        genericButton.tag = buttonName
        genericButton.restorationIdentifier = playerNumber
        genericButton.setTitleColor(UserDefaults.standard.color(forKey: "playerNameColor"), for: .normal)
        genericButton.addTarget(self, action: #selector(lifeChangePress(sender:)), for: UIControl.Event.touchDown)
        
        self.view.addSubview(genericButton)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        lifeTotalP3 = lifeTotalT
        lifeTotalP4 = lifeTotalT
        
        Player1Label.textColor = textColor;
        Player1Label.text = String(lifeTotalP1)
        Player1Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player1Label.center = CGPoint(x: view.frame.width - view.frame.width/4, y: view.frame.height/4)
        Player1Label.textAlignment = .center
        
        Player2Label.textColor = textColor;
        Player2Label.text = String(lifeTotalP2)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player2Label.center = CGPoint(x: view.frame.width - view.frame.width/4, y: view.frame.height - view.frame.height/4)
        Player2Label.textAlignment = .center
        
        Player3Label.textColor = textColor;
        Player3Label.text = String(lifeTotalP3)
        Player3Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        Player3Label.center = CGPoint(x: view.frame.width/4, y: view.frame.height - view.frame.height/4)
        Player3Label.textAlignment = .center
        
        Player4Label.textColor = textColor;
        Player4Label.text = String(lifeTotalP4)
        Player4Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        Player4Label.center = CGPoint(x: view.frame.width/4, y: view.frame.height/4)
        Player4Label.textAlignment = .center
    }
    func loadDividers(){
        let middleRect = CGRect(x: (view.frame.width / 2)-5, y: 0, width: 10, height: view.frame.height)
        let middleView = UIView(frame: middleRect)
        middleView.backgroundColor = dividerColor
        middleView.restorationIdentifier = "divider"
        
        let fullSideRect = CGRect(x: 0, y: (view.frame.height/2)-5, width: view.frame.width, height: 10)
        let fullSideView = UIView(frame: fullSideRect)
        fullSideView.backgroundColor = dividerColor
        fullSideView.restorationIdentifier = "divider"
        
        let leftFullRect = CGRect(x: -10, y: 0, width:20, height: view.frame.height)
        let leftFullView = UIView(frame: leftFullRect)
        leftFullView.backgroundColor = dividerColor
        leftFullView.restorationIdentifier = "divider"
        
        let rightFullRect = CGRect(x: view.frame.width - 10, y: 0, width:20, height: view.frame.height)
        let rightFullView = UIView(frame: rightFullRect)
        rightFullView.backgroundColor = dividerColor
        rightFullView.restorationIdentifier = "divider"
        
        let topFullRect = CGRect(x: 0, y: -10, width: view.frame.width, height: 20)
        let topFullView = UIView(frame: topFullRect)
        topFullView.backgroundColor = dividerColor
        topFullView.restorationIdentifier = "divider"
        
        let bottomFullRect = CGRect(x: 0, y: view.frame.height-10, width: view.frame.width, height: 20)
        let bottomFullView = UIView(frame: bottomFullRect)
        bottomFullView.backgroundColor = dividerColor
        bottomFullView.restorationIdentifier = "divider"
        
        var image = UIImage() ?? UIImage(named: "Home Icon - Dark")
        if (UserDefaults.standard.bool(forKey: "darkThemeIsOn")){
            image = UIImage(named: "Home Icon - Dark")
        }
        else{
            image = UIImage(named: "Home Icon - Light 1")
        }
        
        let settingsButton = UIButton(type: .custom)
        settingsButton.frame = CGRect(x: view.center.x-25, y: view.center.y-25, width: 50, height: 50)
        settingsButton.layer.cornerRadius = 0.5 * settingsButton.bounds.size.width
        settingsButton.clipsToBounds = true
        settingsButton.restorationIdentifier = "settings"
        settingsButton.backgroundColor = .clear
        settingsButton.setImage(image, for: .normal)
        settingsButton.addTarget(self, action: #selector(backButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(leftFullView)
        self.view.addSubview(rightFullView)
        self.view.addSubview(topFullView)
        self.view.addSubview(bottomFullView)
        
        self.view.addSubview(fullSideView)
        self.view.addSubview(middleView)
        self.view.addSubview(settingsButton)
    }
//    @objc func settingsPressed(sender: UIButton){
//        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "settings") as! SettingsView
//        settingsVC.passDataBackDelegate = self
//        present(settingsVC, animated: true, completion: nil)
//    }
    @objc func backButton(sender: UIButton) {
        let alert = UIAlertController(title: "Confirm", message: "Quit to the main menu?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
extension LifeViewController4Players : passDataBack{
    func choices(passedDividerColor: UIColor!,passedTextColor: UIColor!, passedBackgroundColor: UIColor!, passedFontSize: CGFloat!, viewStayOnPassed: Bool!, passedPlayerNameColor: UIColor!) {
        backgroundColor = passedBackgroundColor
        textColor = passedTextColor
        fontSize = passedFontSize
        viewStayOn = viewStayOnPassed
        dividerColor = passedDividerColor
        playerNameColor = passedPlayerNameColor
    }
}
