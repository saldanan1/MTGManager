//
//  LifeViewController.swift
//  MTGManager
//
//  Created by Noah Saldaña on 7/20/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
class LifeViewController2Players: UIViewController{
    var lifeTotalT: Int!
    var lifeTotalP1: Int!
    var lifeTotalP2: Int!
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    var customYellow: UIColor! = UIColor(red: 1, green: 181/255, blue: 49/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        lifeTotalP1 = lifeTotalT
        lifeTotalP2 = lifeTotalT
        refreshLife()
        manageLifeChangeButtons()
        loadDividers()
        loadBackButton()
        Player1Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func refreshLife(){
        Player1Label.text = String(lifeTotalP1);
        Player2Label.text = String(lifeTotalP2);
    }
    func manageLifeChangeButtons(){
        //lower down tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: (view.frame.height-view.frame.height/2), cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Down Tick", playerNumber: "Player 2")
        //lower up tick
        loadChangeLifeTotalButtons(cgX: view.frame.width-view.frame.width/2, cgY: (view.frame.height-view.frame.height/2), cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Up Tick", playerNumber: "Player 2")
        //upper up tick
        loadChangeLifeTotalButtons(cgX: 0, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Up Tick", playerNumber: "Player 1")
        //upper down tick
        loadChangeLifeTotalButtons(cgX: view.frame.width/2, cgY: 0, cgWidth: view.frame.width/2, cgHeight: view.frame.height/2, buttonName: "Down Tick",playerNumber: "Player 1")
    }
    @objc func lifeChangePress(sender: UIButton) {
        UIView.transition(with: sender, duration: 0.05, options: .curveEaseInOut, animations: {
            sender.backgroundColor = .black
            sender.setTitle("", for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .darkGray
            self.view.bringSubviewToFront(self.Player1Label)
            self.view.bringSubviewToFront(self.Player2Label)
        })
        if (sender.titleLabel?.text == "Up Tick"){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 += 1
            }
            else{
                lifeTotalP2 += 1
            }
        }
        else if (sender.titleLabel?.text == "Down Tick"){
            if (sender.restorationIdentifier == "Player 1"){
                lifeTotalP1 -= 1
            }
            else{
                lifeTotalP2 -= 1
            }
        }
        refreshLife()
    }
    func loadDividers(){
        let sideRect = CGRect(x: 0, y: view.frame.height/2, width: (view.frame.width), height: 20)
        let sideView = UIView(frame: sideRect)
        sideView.backgroundColor = customYellow
        
        let bottomRect = CGRect(x: 0, y: view.frame.height-30, width: (view.frame.width), height: 40)
        let bottomView = UIView(frame:bottomRect)
        bottomView.backgroundColor = customYellow
        
        let topRect = CGRect(x:0, y:0, width: (view.frame.width), height: 40)
        let topView = UIView(frame:topRect)
        topView.backgroundColor = customYellow
        
        //self.view.addSubview(topView)
        //self.view.addSubview(bottomView)
        self.view.addSubview(sideView)
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
}

