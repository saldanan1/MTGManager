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
    var customYellow: UIColor! = UIColor(red: 1, green: 181/255, blue: 49/255, alpha: 1)
    
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var Player3Label: UILabel!
    @IBOutlet weak var Player4Label: UILabel!
    @IBOutlet weak var Player5Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTransformAndAssign()
        loadButtons()
        loadDividers()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func loadButtons(){
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
    
    func labelTransformAndAssign(){
        Player1Label.text = String(lifeTotalT)
        Player1Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player2Label.text = String(lifeTotalT)
        Player2Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player3Label.text = String(lifeTotalT)
        Player3Label.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        Player4Label.text = String(lifeTotalT)
        Player4Label.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        
        Player5Label.text = String(lifeTotalT)
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
        
        self.view.addSubview(topView)
        self.view.addSubview(bottomView)
        self.view.addSubview(leftSideView)
        self.view.addSubview(rightSideFirstView)
        self.view.addSubview(rightSideSecondView)
        self.view.addSubview(middleView)
    }
    @objc func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
