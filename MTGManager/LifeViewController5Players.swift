//
//  LifeViewController5Players.swift
//  MTGManager
//
//  Created by Noah Saldaña on 8/28/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class LifeViewController5Players: UIViewController{
    var lifeTotalT: Int!
    
    var lifeTotalP1: Int!
    var lifeTotalP2: Int!
    var lifeTotalP3: Int!
    var lifeTotalP4: Int!
    var lifeTotalP5: Int!

    var textColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    var dividerColor: UIColor! = .gray
    var backgroundColor: UIColor! = .darkGray
    var fontSize: CGFloat! = 75.0
    var viewStayOn: Bool!
    
    var playerOneName: String! = ""
    var playerTwoName: String! = ""
    var playerThreeName: String! = ""
    var playerFourName: String! = ""
    var playerFiveName: String! = ""
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    @IBOutlet weak var Player4Label: UILabel!
    @IBOutlet weak var Player5Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageLifeTotals()
        manageLifeChangeButtons()
        refresh()
        loadDividers()
        loadBackButton()
        loadUserDefaults()
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
        
        Player1Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player2Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player3Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player4Label.textColor = UserDefaults.standard.color(forKey: "textColor")
        Player5Label.textColor = UserDefaults.standard.color(forKey: "textColor")
    }
    func refresh(){
        
        Player1Label.text = String(lifeTotalP1)
        Player2Label.text = String(lifeTotalP2)
        Player3Label.text = String(lifeTotalP3)
        Player4Label.text = String(lifeTotalP4)
        Player5Label.text = String(lifeTotalP5)
        
        for case let button as UIButton in self.view.subviews {
            if (button.restorationIdentifier != "settings"){
                button.backgroundColor = backgroundColor
            }
        }
        for case let text as UILabel in self.view.subviews{
            if (text.restorationIdentifier != "someLabel"){
                text.textColor = textColor
                self.view.bringSubviewToFront(text)
                text.font = UIFont(name:"HelveticaNeue-Bold", size: fontSize)
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
        loadChangeLifeTotalButtons(cgX: (view.frame.width/2), cgY: (view.frame.height/6), cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: 0, playerNumber: "Player 1")
        //player 1 (right side, top life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: (view.frame.height/6), buttonName: 1, playerNumber: "Player 1")
        
        //player 2 (right side, middle life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: 0, playerNumber: "Player 2")
        //player 2 (right side, middle life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/3, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: 1, playerNumber: "Player 2")
        
        //player 3 (right side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height - view.frame.height/6, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: 0, playerNumber: "Player 3")
        //player 3 (right side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height-(view.frame.height/3), cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: 1, playerNumber: "Player 3")
        
        //player 3 (left side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 4")
        //player 3 (left side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 4")
        
        //player 4 (left side, top life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 0, playerNumber: "Player 5")
        //player 4 (left side, top life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: 1, playerNumber: "Player 5")
        
        //player 1 name label/button
        loadPlayerName(cgX: 0, cgY: 0, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerOneName)
        
        //player 2 name label/button
        loadPlayerName(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/9, cgHeight: view.frame.height/2, playerName: playerTwoName)
        
        //player 3 name label/button
        loadPlayerName(cgX: view.frame.width - view.frame.width/9, cgY: 0, cgWidth: view.frame.width/9, cgHeight: view.frame.height/3, playerName: playerThreeName)
        
        //player 4 name label/button
        loadPlayerName(cgX: view.frame.width - view.frame.width/9, cgY: view.frame.height/3, cgWidth: view.frame.width/9, cgHeight: view.frame.height/3, playerName: playerFourName)
        
        //player 5 name label/button
        loadPlayerName(cgX: view.frame.width - view.frame.width/9, cgY: 2*(view.frame.height/3), cgWidth: view.frame.width/9, cgHeight: view.frame.height/3, playerName: playerFiveName)
    }
    func loadPlayerName(cgX: CGFloat, cgY: CGFloat, cgWidth: CGFloat, cgHeight: CGFloat, playerName: String){
        var widthToAdd: CGFloat = 0.0
        if (playerName == playerOneName || playerName == playerTwoName){
            widthToAdd = cgWidth/4
        }
        else{
            widthToAdd = -cgWidth/4
        }
        let genericRect = CGRect(x: cgX + widthToAdd, y: cgY, width: cgWidth, height: cgHeight)
        let genericNameButton = UIButton(frame: genericRect)
        if (playerName == playerOneName || playerName == playerTwoName){
            genericNameButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        }
        else{
            genericNameButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        }
        genericNameButton.restorationIdentifier = "playerNameDivider"
        genericNameButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 45)
        genericNameButton.setTitleColor(.blue, for: .normal)
        genericNameButton.setTitle(playerName, for: .normal)
        genericNameButton.backgroundColor = dividerColor
        genericNameButton.sizeToFit()
        
        self.view.addSubview(genericNameButton)
    }
    @objc func lifeChangePress(sender: UIButton) {
        UIView.transition(with: sender, duration: 0.05, options: .curveEaseInOut, animations: {
            sender.backgroundColor = .black
            sender.setTitle("", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = self.backgroundColor
            self.view.bringSubviewToFront(self.Player1Label)
            self.view.bringSubviewToFront(self.Player2Label)
            self.view.bringSubviewToFront(self.Player3Label)
            self.view.bringSubviewToFront(self.Player4Label)
            self.view.bringSubviewToFront(self.Player5Label)
        })
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
            else if (sender.restorationIdentifier == "Player 4"){
                lifeTotalP4 += 1
            }
            else {
                lifeTotalP5 += 1
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
            else if (sender.restorationIdentifier == "Player 4"){
                lifeTotalP4 -= 1
            }
            else {
                lifeTotalP5 -= 1
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
        genericButton.setTitleColor(UIColor(red: 0.0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        genericButton.addTarget(self, action: #selector(lifeChangePress(sender:)), for: UIControl.Event.touchDown)
        
        self.view.addSubview(genericButton)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func loadBackButton(){
        let someRect = CGRect(x: 30, y: 30, width: 40, height: 40)
        let buttonView = UIView(frame: someRect)
        
        let backButton = UIButton(type: .system);
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        backButton.addTarget(self, action: #selector(backButton(sender:)), for: UIControl.Event.touchDown)
        backButton.sizeToFit()
        buttonView.addSubview(backButton)
        
        self.view.addSubview(buttonView)
        self.view.bringSubviewToFront(buttonView)
    }
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        lifeTotalP3 = lifeTotalT
        lifeTotalP4 = lifeTotalT
        lifeTotalP5 = lifeTotalT
        
        Player1Label.textColor = textColor;
        Player1Label.text = String(lifeTotalP1)
        Player1Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player1Label.center = CGPoint(x: view.frame.width - 5*(view.frame.width/16), y: view.frame.height/6)
        Player1Label.textAlignment = .center
        
        Player2Label.textColor = textColor;
        Player2Label.text = String(lifeTotalP2)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player2Label.center = CGPoint(x: view.frame.width - 5*(view.frame.width/16), y: view.frame.height/2)
        Player2Label.textAlignment = .center
        
        Player3Label.textColor = textColor;
        Player3Label.text = String(lifeTotalP3)
        Player3Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player3Label.center = CGPoint(x: view.frame.width - 5*(view.frame.width/16), y: view.frame.height - view.frame.height/6)
        Player3Label.textAlignment = .center
        
        Player4Label.textColor = textColor;
        Player4Label.text = String(lifeTotalP4)
        Player4Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        Player4Label.center = CGPoint(x: 5*(view.frame.width/16), y: view.frame.height - view.frame.height/4)
        Player4Label.textAlignment = .center
        
        Player5Label.textColor = textColor;
        Player5Label.text = String(lifeTotalP5)
        Player5Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        Player5Label.center = CGPoint(x: 5*(view.frame.width/16), y: view.frame.height/4)
        Player5Label.textAlignment = .center
    }
    
    func loadDividers(){
        let middleRect = CGRect(x: (view.frame.width / 2)-10, y: 0, width: 20, height: view.frame.height)
        let middleView = UIView(frame: middleRect)
        middleView.backgroundColor = dividerColor
        middleView.restorationIdentifier = "divider"
        
        let leftSideRect = CGRect(x: 0, y: (view.frame.height/2)-10, width: view.frame.width/2, height: 20)
        let leftSideView = UIView(frame: leftSideRect)
        leftSideView.backgroundColor = dividerColor
        leftSideView.restorationIdentifier = "divider"
        
        let rightSideFirstRect = CGRect(x: view.frame.width/2, y: (view.frame.height/3)-10, width: view.frame.width/2, height: 20)
        let rightSideFirstView = UIView(frame: rightSideFirstRect)
        rightSideFirstView.backgroundColor = dividerColor
        rightSideFirstView.restorationIdentifier = "divider"
        
        let rightSideSecondRect = CGRect(x: view.frame.width/2, y: ((2*view.frame.height)/3)-10, width: view.frame.width/2, height: 20)
        let rightSideSecondView = UIView(frame: rightSideSecondRect)
        rightSideSecondView.backgroundColor = dividerColor
        rightSideSecondView.restorationIdentifier = "divider"
        
        let settingsButton = UIButton(type: .custom)
        settingsButton.frame = CGRect(x: view.center.x-25, y: view.center.y-25, width: 50, height: 50)
        settingsButton.layer.cornerRadius = 0.5 * settingsButton.bounds.size.width
        settingsButton.clipsToBounds = true
        settingsButton.restorationIdentifier = "settings"
        settingsButton.backgroundColor = .clear
        let image = UIImage(named: "gear") as UIImage?
        settingsButton.setImage(image, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        
        self.view.addSubview(leftSideView)
        self.view.addSubview(rightSideFirstView)
        self.view.addSubview(rightSideSecondView)
        self.view.addSubview(middleView)
        self.view.addSubview(settingsButton)
    }
    @objc func settingsPressed(sender: UIButton){
        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "settings") as! SettingsView
        settingsVC.passDataBackDelegate = self
        present(settingsVC, animated: true, completion: nil)
    }
    @objc func backButton(sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
extension LifeViewController5Players : passDataBack{
    func choices(passedDividerColor: UIColor!, passedTextColor: UIColor!, passedBackgroundColor: UIColor!, passedFontSize: CGFloat!, viewStayOnPassed: Bool!) {
        backgroundColor = passedBackgroundColor
        textColor = passedTextColor
        fontSize = passedFontSize
        viewStayOn = viewStayOnPassed
        dividerColor = passedDividerColor
    }
}
