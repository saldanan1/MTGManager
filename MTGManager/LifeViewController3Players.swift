//
//  LifeViewController3Players.swift
//  MTGManager
//
//  Created by Noah Saldaña on 7/24/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class LifeViewController3Players: UIViewController{
    var lifeTotalT: Int!
    var lifeTotalP1: Int!
    var lifeTotalP2: Int!
    var lifeTotalP3: Int!
    
    var customYellow: UIColor! = UIColor(red: 1, green: 181/255, blue: 49/255, alpha: 1)
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageLifeTotals()
        manageLifeChangeButtons()
        refreshLife()
        loadDividers()
        loadBackButton()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func refreshLife(){
        Player1Label.text = String(lifeTotalP1)
        Player2Label.text = String(lifeTotalP2)
        Player3Label.text = String(lifeTotalP3)
    }
    func manageLifeTotals(){
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        lifeTotalP3 = lifeTotalT
        
        Player1Label.text = String(lifeTotalP1)
        Player1Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        Player1Label.center = CGPoint(x: view.center.x/2, y: view.center.y)
        Player1Label.textAlignment = .center
        
        Player2Label.text = String(lifeTotalP2)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player2Label.center = CGPoint(x: view.frame.width - view.frame.width/4, y: view.frame.height/4)
        Player2Label.textAlignment = .center
        
        Player3Label.text = String(lifeTotalP3)
        Player3Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        Player3Label.center = CGPoint(x: view.frame.width-view.frame.width/4, y: view.frame.height - view.frame.height/4)
        Player3Label.textAlignment = .center
    }
    func manageLifeChangeButtons(){
        //player 1 (left side) down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Down Tick", playerNumber: "Player 1")
        //player 1 (left side) up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Up Tick", playerNumber: "Player 1")
        
        //player 2 (right side, top life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 2")
        //player 2 (right side, top life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 2")
        
        //player 3 (right side, bottom life) down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height/2, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Up Tick", playerNumber: "Player 3")
        //player 3 (right side, bottom life) up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: view.frame.height - view.frame.height/4, cgWidth: view.frame.width/2, cgHeight: view.frame.height/4, buttonName: "Down Tick", playerNumber: "Player 3")
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
        })
        if (sender.titleLabel?.text == "Up Tick"){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 += 1
            }
            else if (sender.restorationIdentifier == "Player 2"){
                lifeTotalP2 += 1
            }
            else {
                lifeTotalP3 += 1
            }
        }
        else if (sender.titleLabel?.text == "Down Tick"){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 -= 1
            }
            else if (sender.restorationIdentifier == "Player 2"){
                lifeTotalP2 -= 1
            }
            else {
                lifeTotalP3 -= 1
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
    @objc func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func loadDividers(){
        let middleRect = CGRect(x: (view.frame.width / 2)-10, y: 0, width: 20, height: view.frame.height)
        let middleView = UIView(frame: middleRect)
        middleView.backgroundColor = customYellow
        
        let sideRect = CGRect(x: (view.frame.width/2), y: (view.frame.height/2)-10, width: (view.frame.width/2), height: 20)
        let sideView = UIView(frame: sideRect)
        sideView.backgroundColor = customYellow
        
        let bottomRect = CGRect(x: 0, y: view.frame.height-40, width: (view.frame.width), height: 40)
        let bottomView = UIView(frame:bottomRect)
        bottomView.backgroundColor = customYellow
        
        let topRect = CGRect(x:0, y:0, width: (view.frame.width), height: 40)
        let topView = UIView(frame:topRect)
        topView.backgroundColor = customYellow
        
        //self.view.addSubview(topView)
        //self.view.addSubview(bottomView)
        self.view.addSubview(sideView)
        self.view.addSubview(middleView)
    }
}
