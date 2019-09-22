//
//  LifeViewController.swift
//  MTGManager
//
//  Created by Noah Saldaña on 7/20/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit
class LifeViewController2Players: UIViewController{
    var lifeTotalT: Int!
    
    var lifeTotalP1: Int!
    var lifeTotalP2: Int!
    
    var dividerColor: UIColor! = .gray
    var textColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    var backgroundColor: UIColor! = .darkGray
    var fontSize: CGFloat! = 75.0
    var viewStayOn: Bool!
    var playerNameColor: UIColor! = .black
    
    var playerOneName: String! = ""
    var playerTwoName: String! = ""
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    
    @IBOutlet weak var plusTop: UILabel!
    @IBOutlet weak var minusTop: UILabel!
    @IBOutlet weak var minusBottom: UILabel!
    @IBOutlet weak var plusBottom: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageLifeTotals()
        refresh()
        manageView()
        loadDividers()
        loadBackButton()
        loadUserDefaults()
        handlePlusMinus()
    }
    override func viewWillAppear(_ animated: Bool){
        refresh()
        if (viewStayOn == true){
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
    func handlePlusMinus(){
        for case let text as UILabel in self.view.subviews{
            if (text.accessibilityIdentifier == "plusMinusButtons"){
                text.textColor = textColor
                text.font = UIFont(name:"HelveticaNeue-Bold", size: 45)
                self.view.bringSubviewToFront(text)
            }
        }
        plusTop.center.x = self.view.frame.width/4
        plusTop.center.y = self.view.frame.height/4
    }
    func loadUserDefaults(){
        backgroundColor = UserDefaults.standard.color(forKey: "previewView")
        dividerColor = UserDefaults.standard.color(forKey: "dividerColor")
        fontSize = CGFloat(UserDefaults.standard.integer(forKey: "fontSize"))
        playerNameColor = UserDefaults.standard.color(forKey: "playerNameColor")
        textColor = UserDefaults.standard.color(forKey: "textColor")
        
        Player1Label.textColor = textColor
        Player2Label.textColor = textColor
    }
    func refresh(){
        
        Player1Label.text = String(lifeTotalP1);
        Player2Label.text = String(lifeTotalP2);
        
        for case let button as UIButton in self.view.subviews { //select all butons view except the settings button
            if (button.restorationIdentifier != "settings"){
                button.backgroundColor = backgroundColor
            }
            if (button.restorationIdentifier == "playerNameText"){
                button.setTitleColor(playerNameColor, for: .normal)
            }
        }
        for case let text as UILabel in self.view.subviews{ //select all labels in view except someLabel (in case I need to exclude some label later)
            if (text.restorationIdentifier != "playerNameDivider" && text.accessibilityIdentifier != "plusMinusButtons"){
                text.textColor = UserDefaults.standard.color(forKey: "textColor")
                self.view.bringSubviewToFront(text)
                text.font = UIFont(name:"HelveticaNeue-Bold", size: fontSize)
                text.sizeToFit()
            }
            if (text.restorationIdentifier == "playerNameDivider"){
                text.backgroundColor = dividerColor
            }
        }
        for case let view as UIView in self.view.subviews{
            if (view.restorationIdentifier == "divider"){
                view.backgroundColor = dividerColor
            }
        }
        Player1Label.center = CGPoint(x: view.center.x, y: 5*(view.frame.height/16))
        Player2Label.center = CGPoint(x: view.center.x, y: view.frame.height - 5*(view.frame.height/16))
        
    }
    func manageView(){
        //lower down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: (view.frame.height-view.frame.height/2), cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: 0, playerNumber: "Player 2")
        //lower up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width-view.frame.width/2, cgY: (view.frame.height-view.frame.height/2), cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: 1, playerNumber: "Player 2")
        //upper up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: 1, playerNumber: "Player 1")
        //upper down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: 0, playerNumber: "Player 1")
        
        //player 1 name label/button
        loadPlayerName(cgX: 0, cgY: 0, cgWidth: view.frame.width, cgHeight: view.frame.height/9, playerName: playerOneName)
        
        //player 2 name label/button
        loadPlayerName(cgX: view.center.x, cgY: view.frame.height - view.frame.height/9, cgWidth: 100, cgHeight: view.frame.height/9, playerName: playerTwoName)
    }
    
    func loadPlayerName(cgX: CGFloat, cgY: CGFloat, cgWidth: CGFloat, cgHeight: CGFloat, playerName: String){
        var heightToAdd: CGFloat = 0.0
        if (playerName == playerOneName){
            heightToAdd = cgHeight/8
        }
        else{
            heightToAdd = -cgHeight/8
        }
        let genericRect = CGRect(x: cgX, y: cgY + heightToAdd, width: cgWidth, height: cgHeight)
        let genericNameButton = UIButton(frame: genericRect)
        if (playerName == playerOneName){
            genericNameButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        }
        genericNameButton.restorationIdentifier = "playerNameText"
        genericNameButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 45)
        genericNameButton.setTitleColor(playerNameColor, for: .normal)
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
        })
        if (sender.tag == 1){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 += 1
            }
            else{
                lifeTotalP2 += 1
            }
        }
        else if (sender.tag == 0){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 -= 1
            }
            else{
                lifeTotalP2 -= 1
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
        
        Player1Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    func loadDividers(){
        let sideRect = CGRect(x: 0, y: (view.frame.height/2)-10, width: (view.frame.width), height: 20)
        let sideView = UIView(frame: sideRect)
        sideView.backgroundColor = dividerColor
        sideView.restorationIdentifier = "divider"
        
        let image = UIImage(named: "gear") as UIImage?
        
        let settingsButton = UIButton(type: .custom)
        settingsButton.frame = CGRect(x: view.center.x-25, y: view.center.y-25, width: 50, height: 50)
        settingsButton.layer.cornerRadius = 0.5 * settingsButton.bounds.size.width
        settingsButton.clipsToBounds = true
        settingsButton.restorationIdentifier = "settings"
        settingsButton.backgroundColor = .clear
        settingsButton.setImage(image, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        
        self.view.addSubview(sideView)
        self.view.addSubview(settingsButton)
    }
    @objc func settingsPressed(sender: UIButton){
        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "settings") as! SettingsView
        settingsVC.passDataBackDelegate = self
        present(settingsVC, animated: true, completion: nil)
    }
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
extension LifeViewController2Players : passDataBack{
    func choices(passedDividerColor: UIColor!, passedTextColor: UIColor!, passedBackgroundColor: UIColor!, passedFontSize: CGFloat!, viewStayOnPassed: Bool!, passedPlayerNameColor: UIColor!) {
        backgroundColor = passedBackgroundColor
        textColor = passedTextColor
        fontSize = passedFontSize
        viewStayOn = viewStayOnPassed
        dividerColor = passedDividerColor
        playerNameColor = passedPlayerNameColor
    }
}

