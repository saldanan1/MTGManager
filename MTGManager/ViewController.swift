//
//  ViewController.swift
//  MTGManager
//
//  Created by Noah Saldaña on 7/19/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    var numOfPlayers = 2
    var lifeTotal: Int = 20
    @IBOutlet weak var playerOneText: UITextField!
    @IBOutlet weak var playerTwoText: UITextField!
    @IBOutlet weak var playerThreeText: UITextField!
    @IBOutlet weak var playerFourText: UITextField!
    @IBOutlet weak var playerFiveText: UITextField!
    
    @IBOutlet var numberPlayerControl : UISegmentedControl!;
    @IBOutlet weak var lifeTotalControl: UISegmentedControl!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for case let textField as UITextField in self.view.subviews { //select all UITextFields
            if (textField.restorationIdentifier != "someID"){
                textField.endEditing(true)
            }
        }
    }
    
    @IBAction func playersChanged(sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            numOfPlayers = 2;
            playerOneText.isHidden = false;
            playerTwoText.isHidden = false;
            
            playerThreeText.isHidden = true;
            playerFourText.isHidden = true;
            playerFiveText.isHidden = true;
        case 1:
            numOfPlayers = 3;
            playerThreeText.isHidden = false;
        case 2:
            numOfPlayers = 4;
        case 3:
            numOfPlayers = 5;
        default:
            break;
        }
    }
    @IBAction func lifeChanged(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            self.lifeTotal = 20;
        }
        else if(sender.selectedSegmentIndex == 1){
            self.lifeTotal = 30;
        }
        else if(sender.selectedSegmentIndex == 2){
            self.lifeTotal = 40;
        }
        else if(sender.selectedSegmentIndex == 3){
            self.lifeTotal = 50;
        }
        else if(sender.selectedSegmentIndex == 4){
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlayerInputFields()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: Notification){
        view.frame.origin.y = -((view.frame.height)/3)
    }
    @objc func keyboardWillHide(notification: Notification){
        view.frame.origin.y = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        createPlayerInputFields()
    }
    func createPlayerInputFields(){
        let textFieldRect = CGRect(x: 0, y: view.frame.height - view.frame.height/2, width: view.frame.width, height:  view.frame.height - view.frame.height/2)
        
        let player1Label = UILabel(frame:textFieldRect)
        let player2Label = UILabel(frame:textFieldRect)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is LifeViewController2Players
        {
            let vc = segue.destination as? LifeViewController2Players
            vc?.lifeTotalT = lifeTotal
        }
        else if segue.destination is LifeViewController3Players
        {
            let vc = segue.destination as? LifeViewController3Players
            vc?.lifeTotalT = lifeTotal
        }
        else if segue.destination is LifeViewController4Players{
            let vc = segue.destination as? LifeViewController4Players
            vc?.lifeTotalT = lifeTotal
        }
        else if segue.destination is LifeViewController5Players{
            let vc = segue.destination as? LifeViewController5Players
            vc?.lifeTotalT = lifeTotal
        }
    }
    @IBAction func startClicked(_ sender: Any) {
        let segueString = "players" + String(numOfPlayers)
        performSegue(withIdentifier: segueString, sender: nil)
    }
}

