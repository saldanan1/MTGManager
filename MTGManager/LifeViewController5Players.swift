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
    
    var customYellow: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    var labelColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    @IBOutlet weak var Player4Label: UILabel!
    @IBOutlet weak var Player5Label: UILabel!
    
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
        Player5Label.text = String(lifeTotalP5)
    }
    func manageLifeChangeButtons(){
        //player 1 (right side, top life) down tick
        loadChangeLifeTotalButtons(cgX: (view.frame.width/2), cgY: (view.frame.height/6), cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: "Down Tick", playerNumber: "Player 1")
        //player 1 (right side, top life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: (view.frame.height/6), buttonName: "Up Tick", playerNumber: "Player 1")
        
        //player 2 (right side, middle life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/3, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: "Up Tick", playerNumber: "Player 2")
        //player 2 (right side, middle life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: "Down Tick", playerNumber: "Player 2")
        
        //player 3 (right side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height-(view.frame.height/3), cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: "Up Tick", playerNumber: "Player 3")
        //player 3 (right side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height - view.frame.height/6, cgWidth: view.frame.width/2, cgHeight: view.frame.height/6, buttonName: "Down Tick", playerNumber: "Player 3")
        
        //player 3 (left side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 4")
        //player 3 (left side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 4")
        
        //player 4 (left side, top life) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 5")
        //player 4 (left side, top life) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 5")
    }
    @objc func lifeChangePress(sender: UIButton) {
        UIView.transition(with: sender, duration: 0.05, options: .curveEaseInOut, animations: {
            sender.backgroundColor = .black
            sender.setTitle("", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .darkGray
            self.view.bringSubviewToFront(self.Player1Label)
            self.view.bringSubviewToFront(self.Player2Label)
            self.view.bringSubviewToFront(self.Player3Label)
            self.view.bringSubviewToFront(self.Player4Label)
            self.view.bringSubviewToFront(self.Player5Label)
        })
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
            else if (sender.restorationIdentifier == "Player 4"){
                lifeTotalP4 += 1
            }
            else {
                lifeTotalP5 += 1
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
            else if (sender.restorationIdentifier == "Player 4"){
                lifeTotalP4 -= 1
            }
            else {
                lifeTotalP5 -= 1
            }
        }
        refreshLife()
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
    }
    
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        lifeTotalP3 = lifeTotalT
        lifeTotalP4 = lifeTotalT
        lifeTotalP5 = lifeTotalT
        
        Player1Label.textColor = labelColor;
        Player1Label.text = String(lifeTotalP1)
        Player1Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))

        Player2Label.textColor = labelColor;
        Player2Label.text = String(lifeTotalP2)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player3Label.textColor = labelColor;
        Player3Label.text = String(lifeTotalP3)
        Player3Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player4Label.textColor = labelColor;
        Player4Label.text = String(lifeTotalP4)
        Player4Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        
        Player5Label.textColor = labelColor;
        Player5Label.text = String(lifeTotalP5)
        Player5Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
    }
    
    func loadDividers(){
        let middleRect = CGRect(x: (view.frame.width / 2)-10, y: 0, width: 20, height: view.frame.height)
        let middleView = UIView(frame: middleRect)
        middleView.backgroundColor = customYellow
        
        let leftSideRect = CGRect(x: 0, y: view.frame.height/2, width: view.frame.width/2, height: 20)
        let leftSideView = UIView(frame: leftSideRect)
        leftSideView.backgroundColor = customYellow
        
        let rightSideFirstRect = CGRect(x: view.frame.width/2, y: view.frame.height/3, width: view.frame.width/2, height: 20)
        let rightSideFirstView = UIView(frame: rightSideFirstRect)
        rightSideFirstView.backgroundColor = customYellow
        
        let rightSideSecondRect = CGRect(x: view.frame.width/2, y: (2*view.frame.height)/3, width: view.frame.width/2, height: 20)
        let rightSideSecondView = UIView(frame: rightSideSecondRect)
        rightSideSecondView.backgroundColor = customYellow
        
        let bottomRect = CGRect(x: 0, y: view.frame.height-40, width: (view.frame.width), height: 40)
        let bottomView = UIView(frame:bottomRect)
        bottomView.backgroundColor = customYellow
        
        let topRect = CGRect(x:0, y:0, width: (view.frame.width), height: 40)
        let topView = UIView(frame:topRect)
        topView.backgroundColor = customYellow
        
        //self.view.addSubview(topView)
        //self.view.addSubview(bottomView)
        self.view.addSubview(leftSideView)
        self.view.addSubview(rightSideFirstView)
        self.view.addSubview(rightSideSecondView)
        self.view.addSubview(middleView)
    }
    @objc func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
