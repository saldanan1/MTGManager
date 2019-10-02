//
//  ViewController.swift
//  MTGManager
//
//  Created by Noah Saldaña on 7/19/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    var numOfPlayers = 1
    var lifeTotal: Int = 20
    var playerNamesArray: [String] = []
    
    var dividerYellow: UIColor! = UIColor(red: 249/255, green: 179/255, blue: 49/255, alpha: 1)
    var textColorLightYellow: UIColor! = UIColor(red: 255/255, green: 228/255, blue: 122/255, alpha: 1)
    var backgroundGray: UIColor! = UIColor(red: 88/255, green: 85/255, blue: 89/255, alpha: 1)
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var numPlayersView: UIView!
    @IBOutlet weak var numLifeView: UIView!
    @IBOutlet weak var lifeView: UIView!
    @IBOutlet weak var startButtonView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var playerOneText: UITextField!
    @IBOutlet weak var playerOneLabel: UILabel!
    
    @IBOutlet weak var playerTwoText: UITextField!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBOutlet weak var playerThreeText: UITextField!
    @IBOutlet weak var playerThreeLabel: UILabel!
    
    @IBOutlet weak var playerFourText: UITextField!
    @IBOutlet weak var playerFourLabel: UILabel!
    
    @IBOutlet weak var playerFiveText: UITextField!
    @IBOutlet weak var playerFiveLabel: UILabel!
    
    @IBOutlet var numberPlayerControl : UISegmentedControl!;
    @IBOutlet weak var lifeTotalControl: UISegmentedControl!
    
    
    
    @IBAction func playersChanged(sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            numOfPlayers = 1;
            playerOneText.isHidden = false
            playerOneLabel.isHidden = false
            
            playerTwoText.isHidden = true
            playerTwoLabel.isHidden = true
            playerThreeText.isHidden = true
            playerThreeLabel.isHidden = true
            playerFourText.isHidden = true
            playerFourLabel.isHidden = true
            playerFiveText.isHidden = true
            playerFiveLabel.isHidden = true
        case 1:
            numOfPlayers = 2;
            playerOneText.isHidden = false
            playerOneLabel.isHidden = false
            playerTwoText.isHidden = false
            playerTwoLabel.isHidden = false
            
            playerThreeText.isHidden = true
            playerThreeLabel.isHidden = true
            playerFourText.isHidden = true
            playerFourLabel.isHidden = true
            playerFiveText.isHidden = true
            playerFiveLabel.isHidden = true
        case 2:
            numOfPlayers = 3;
            playerThreeText.isHidden = false
            playerThreeLabel.isHidden = false
            playerTwoText.isHidden = false
            playerTwoLabel.isHidden = false
            
            playerFourText.isHidden = true
            playerFourLabel.isHidden = true
            playerFiveText.isHidden = true
            playerFiveLabel.isHidden = true
        case 3:
            numOfPlayers = 4;
            playerTwoText.isHidden = false
            playerTwoLabel.isHidden = false
            playerThreeText.isHidden = false
            playerThreeLabel.isHidden = false
            playerFourText.isHidden = false
            playerFourLabel.isHidden = false
            
            playerFiveText.isHidden = true
            playerFiveLabel.isHidden = true
        case 4:
            numOfPlayers = 5;
            playerTwoText.isHidden = false
            playerTwoLabel.isHidden = false
            playerThreeText.isHidden = false
            playerThreeLabel.isHidden = false
            playerFourText.isHidden = false
            playerFourLabel.isHidden = false
            playerFiveText.isHidden = false
            playerFiveLabel.isHidden = false
        default:
            break;
        }
    }
    @IBAction func darkThemeOn(_ sender: UISwitch) {
        if (sender.isOn == true){
            UserDefaults.standard.set(dividerYellow, forKey: "playerNameColor")
            UserDefaults.standard.set(textColorLightYellow, forKey: "textColor")
            UserDefaults.standard.set(backgroundGray, forKey: "previewView")
            UserDefaults.standard.set(dividerYellow, forKey: "dividerColor")
            UserDefaults.standard.set(true, forKey: "darkThemeIsOn")
            
//            startButtonView.backgroundColor = dividerYellow
//            contentView.backgroundColor = backgroundGray
//            numPlayersView.backgroundColor = dividerYellow
//            numLifeView.backgroundColor = dividerYellow
//            scrollView.backgroundColor = dividerYellow
        }
        else{
            UserDefaults.standard.set(.white, forKey: "textColor")
            UserDefaults.standard.set(backgroundGray, forKey: "dividerColor")
            UserDefaults.standard.set(backgroundGray, forKey: "playerNameColor")
            UserDefaults.standard.set(dividerYellow, forKey: "previewView")
            UserDefaults.standard.set(false, forKey: "darkThemeIsOn")
            
//            startButtonView.backgroundColor = backgroundGray
//            contentView.backgroundColor = dividerYellow
//            numPlayersView.backgroundColor = backgroundGray
//            numLifeView.backgroundColor = backgroundGray
//            scrollView.backgroundColor = backgroundGray
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneText.delegate = self
        playerTwoText.delegate = self
        playerThreeText.delegate = self
        playerFourText.delegate = self
        playerFiveText.delegate = self

        loadUserDefaults()
        self.setupToHideKeyboardOnTapOnView()
        
        scrollView.keyboardDismissMode = .onDrag
        
        contentView.backgroundColor = backgroundGray
        numPlayersView.backgroundColor = dividerYellow
        numLifeView.backgroundColor = dividerYellow
        lifeView.backgroundColor = dividerYellow
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func loadUserDefaults(){
        UserDefaults.standard.set(dividerYellow, forKey: "playerNameColor")
        UserDefaults.standard.set(textColorLightYellow, forKey: "textColor")
        UserDefaults.standard.set(backgroundGray, forKey: "previewView")
        UserDefaults.standard.set(dividerYellow, forKey: "dividerColor")
        UserDefaults.standard.set(self.view.frame.width*0.350, forKey: "fontSize") //font size scalability based on screen width... play with this more, only 3rd attempt
        UserDefaults.standard.set(true, forKey: "keepScreenOn")
        UserDefaults.standard.set(true, forKey: "darkThemeIsOn")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is LifeViewController1Player
        {
            let vc = segue.destination as? LifeViewController1Player
            vc?.lifeTotalT = lifeTotal
            vc?.playerOneName = playerOneText.text
        }
        else if segue.destination is LifeViewController2Players
        {
            let vc = segue.destination as? LifeViewController2Players
            vc?.lifeTotalT = lifeTotal
            vc?.playerOneName = playerOneText.text
            vc?.playerTwoName = playerTwoText.text
        }
        else if segue.destination is LifeViewController3Players
        {
            let vc = segue.destination as? LifeViewController3Players
            vc?.lifeTotalT = lifeTotal
            vc?.playerOneName = playerOneText.text
            vc?.playerTwoName = playerTwoText.text
            vc?.playerThreeName = playerThreeText.text
        }
        else if segue.destination is LifeViewController4Players{
            let vc = segue.destination as? LifeViewController4Players
            vc?.lifeTotalT = lifeTotal
            vc?.playerOneName = playerOneText.text
            vc?.playerTwoName = playerTwoText.text
            vc?.playerThreeName = playerThreeText.text
            vc?.playerFourName = playerFourText.text
        }
        else if segue.destination is LifeViewController5Players{
            let vc = segue.destination as? LifeViewController5Players
            vc?.lifeTotalT = lifeTotal
            vc?.playerOneName = playerOneText.text
            vc?.playerTwoName = playerTwoText.text
            vc?.playerThreeName = playerThreeText.text
            vc?.playerFourName = playerFourText.text
            vc?.playerFiveName = playerFiveText.text
        }
    }
    @IBAction func startClicked(_ sender: Any) {
        let segueString = "players" + String(numOfPlayers)
            performSegue(withIdentifier: segueString, sender: nil)
    }
}
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
