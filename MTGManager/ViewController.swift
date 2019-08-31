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
    
    @IBOutlet var numberPlayerControl : UISegmentedControl!;
    @IBOutlet weak var lifeTotalControl: UISegmentedControl!
    
    @IBAction func playersChanged(sender : UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            numOfPlayers = 2;
        case 1:
            numOfPlayers = 3;
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
            let alert = UIAlertController(title: "Alert", message: "Not yet implemented", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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

