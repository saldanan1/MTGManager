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
    var customYellow: UIColor! = UIColor(red: 1, green: 181/255, blue: 49/255, alpha: 1)
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    @IBOutlet weak var Player4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageLifeTotals()
        manageLifeChangeButtons()
        refreshLife()
        loadDividers()
        loadBackButton()
    }
    func refreshLife(){
        Player1Label.text = String(lifeTotalP1)
        Player2Label.text = String(lifeTotalP2)
        Player3Label.text = String(lifeTotalP3)
        Player4Label.text = String(lifeTotalP4)
    }
    func manageLifeChangeButtons(){
        //player 1 (right side, top life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 1")
        //player 1 (right side, top life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 1")
        
        //player 2 (right side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 2")
        //player 2 (right side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 2")
        
        //player 3 (left side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 3")
        //player 3 (left side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 3")
        
        //player 4 (left side, top life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 4")
        //player 4 (left side, top life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 4")
    }
    @objc func lifeChangePress(sender: UIButton) {
        if (sender.titleLabel?.text == "Up Tick"){
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
        else if (sender.titleLabel?.text == "Down Tick"){
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
        refreshLife()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        lifeTotalP3 = lifeTotalT
        lifeTotalP4 = lifeTotalT
        
        Player1Label.text = String(lifeTotalP1)
        Player1Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player2Label.text = String(lifeTotalP2)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player3Label.text = String(lifeTotalP3)
        Player3Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        
        Player4Label.text = String(lifeTotalP4)
        Player4Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
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
    func loadChangeLifeTotalButtons
        (cgX: CGFloat, cgY: CGFloat, cgWidth: CGFloat, cgHeight: CGFloat, buttonName: String, playerNumber: String){
        
        let genericRect = CGRect(x: cgX, y: cgY, width: cgWidth, height: cgHeight)
        
        let genericButton = UIButton(frame: genericRect)
        genericButton.setTitle(buttonName, for: .normal)
        genericButton.restorationIdentifier = playerNumber
        genericButton.setTitleColor(UIColor(red: 0.0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        genericButton.addTarget(self, action: #selector(lifeChangePress(sender:)), for: UIControl.Event.touchDown)
        
        self.view.addSubview(genericButton)
    }
    @objc func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func loadDividers(){
        let middleRect = CGRect(x: (view.frame.width / 2)-10, y: 0, width: 20, height: view.frame.height)
        let middleView = UIView(frame: middleRect)
        middleView.backgroundColor = customYellow
        
        let fullSideRect = CGRect(x: 0, y: (view.frame.height/2), width: view.frame.width, height: 20)
        let fullSideView = UIView(frame: fullSideRect)
        fullSideView.backgroundColor = customYellow
        
        let bottomRect = CGRect(x: 0, y: view.frame.height-40, width: (view.frame.width), height: 40)
        let bottomView = UIView(frame:bottomRect)
        bottomView.backgroundColor = customYellow
        
        let topRect = CGRect(x:0, y:0, width: (view.frame.width), height: 40)
        let topView = UIView(frame:topRect)
        topView.backgroundColor = customYellow
        
        self.view.addSubview(topView)
        self.view.addSubview(bottomView)
        self.view.addSubview(fullSideView)
        self.view.addSubview(middleView)
    }
}
