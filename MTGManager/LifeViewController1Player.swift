//
//  LifeViewController1Player.swift
//  MTGManager
//
//  Created by Noah Saldaña on 9/29/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit
class LifeViewController1Player: UIViewController{
    var lifeTotalT: Int!
    var lifeTotalP1: Int!
    
    var dividerColor: UIColor! = .gray
    var textColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    var backgroundColor: UIColor! = .darkGray
    var fontSize: CGFloat! = 75.0
    var viewStayOn: Bool!
    var playerNameColor: UIColor! = .black
    var previouslife: Bool = true
    
    var playerOneName: String! = ""
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player1NameLabel: UILabel!
    @IBOutlet weak var plus: UILabel!
    @IBOutlet weak var minus: UILabel!
    
    override func viewDidLoad() {
        manageLifeTotals()
        manageView()
        refresh()
        loadUserDefaults()
        loadDividers()
        handlePlusMinus()
    }
    override func viewWillAppear(_ animated: Bool) {
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
        minus.center.x = self.view.frame.width/8
        minus.center.y = self.view.frame.height - self.view.frame.height/16
        
        plus.center.x = self.view.frame.width - self.view.frame.width/8
        plus.center.y = self.view.frame.height - self.view.frame.height/16
    }
    func manageView(){
    //player 1 up tick
    loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height, buttonName: 1, playerNumber: "Player 1")
    //player 1 down tick
    loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height, buttonName: 0, playerNumber: "Player 1")
        
    Player1NameLabel.restorationIdentifier = "playerNameText"
    Player1NameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
    Player1NameLabel.textColor = UserDefaults.standard.color(forKey: "playerNameColor")
    Player1NameLabel.text = playerOneName
    Player1NameLabel.sizeToFit()
    Player1NameLabel.center.x = self.view.center.x
    Player1NameLabel.center.y = self.view.frame.height - self.view.frame.height/16
    
    self.view.bringSubviewToFront(Player1NameLabel)
    
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
    @objc func lifeChangePress(sender: UIButton) {
            if (sender.tag == 1){
                if (sender.restorationIdentifier == "Player 1"){
                    lifeTotalP1 += 1
                }
            }
            else if (sender.tag == 0){
                if (sender.restorationIdentifier == "Player 1"){
                    lifeTotalP1 -= 1
                }
            }
        
            refresh()
    }
    func refresh(){
        Player1Label.text = String(lifeTotalP1);
        
        for case let button as UIButton in self.view.subviews { //select all butons view except the settings button
            if (button.restorationIdentifier != "settings"){
                button.backgroundColor = backgroundColor
            }
            if (button.restorationIdentifier == "playerNameText"){
            button.setTitleColor(playerNameColor, for: .normal)
            }
        }
        for case let text as UILabel in self.view.subviews{ //select all labels in view except
            if (text.accessibilityIdentifier != "plusMinusButtons" &&
                text.accessibilityIdentifier != "playerNames"){
                text.textColor = UserDefaults.standard.color(forKey: "textColor")
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
        
        Player1Label.center.x = self.view.center.x
        Player1Label.center.y = self.view.center.y
    }
    func loadUserDefaults(){
        backgroundColor = UserDefaults.standard.color(forKey: "previewView")
        dividerColor = UserDefaults.standard.color(forKey: "dividerColor")
        fontSize = CGFloat(UserDefaults.standard.integer(forKey: "fontSize"))
        playerNameColor = UserDefaults.standard.color(forKey: "playerNameColor")
        textColor = UserDefaults.standard.color(forKey: "textColor")
        
        Player1Label.textColor = textColor
    }
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        
    }
    func loadDividers(){
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
        settingsButton.frame = CGRect(x: view.center.x-25, y: view.frame.height/16, width: 50, height: 50)
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
            
            self.view.addSubview(settingsButton)
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

