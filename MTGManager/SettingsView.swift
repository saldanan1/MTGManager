//
//  SettingsView.swift
//  MTGManager
//
//  Created by Noah Saldaña on 9/4/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

class SettingsView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var textCollectionView: UICollectionView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var textInView: UILabel!
    
    var arrayOfColors: [UIColor] = [.red, .black, .blue, .gray, .darkGray, .brown, .cyan, .green, .magenta, .orange]
    var holderColor: UIColor = .red
    let backgroundCollectionViewIndentifier = "backgroundCollection"
    let textCollectionViewIdentifier = "textCollection"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackButton()
        loadSaveButton()
        backgroundCollectionView.dataSource = self
        backgroundCollectionView.delegate = self
        textCollectionView.dataSource = self
        textCollectionView.delegate = self
        previewView.backgroundColor = .red
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.backgroundCollectionView{
            return arrayOfColors.count
        }
        else{
            return arrayOfColors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.backgroundCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: backgroundCollectionViewIndentifier, for: indexPath) as UICollectionViewCell
            let colorView = UIButton(frame: cellA.contentView.frame)
            colorView.backgroundColor = arrayOfColors[indexPath.row]
            colorView.tag = indexPath.row
            colorView.addTarget(self, action: #selector(backgroundColor(sender:)), for: UIControl.Event.touchDown)
            cellA.addSubview(colorView)
            
            return cellA
        }
            
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: textCollectionViewIdentifier, for: indexPath) as UICollectionViewCell
            let colorView = UIButton(frame: cellB.contentView.frame)
            colorView.backgroundColor = arrayOfColors[indexPath.row]
            colorView.tag = indexPath.row
            colorView.addTarget(self, action: #selector(textColor(sender:)), for: UIControl.Event.touchDown)
            cellB.addSubview(colorView)
            // ...Set up cell
            
            return cellB
        }
    }
    @objc func backgroundColor(sender: UIButton){
        let holderColor = arrayOfColors[sender.tag]
        previewView.backgroundColor = holderColor
    }
    @objc func textColor(sender: UIButton){
        let holderColor = arrayOfColors[sender.tag]
        textInView.textColor = holderColor
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func loadBackButton(){
        let someRect = CGRect(x: 10, y: 20, width: 40, height: 40)
        let buttonView = UIView(frame: someRect)
        
        let backButton = UIButton(type: .system);
        backButton.setTitle("Cancel", for: .normal)
        backButton.setTitleColor(UIColor(red: 0.0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        backButton.addTarget(self, action: #selector(cancelButton(sender:)), for: UIControl.Event.touchDown)
        backButton.sizeToFit()
        buttonView.addSubview(backButton)
        
        self.view.addSubview(buttonView)
    }
    func loadSaveButton(){
        let someRect = CGRect(x: view.frame.width-60, y: 20, width: 40, height: 50)
        let buttonView = UIView(frame: someRect)
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor(red: 0.0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButton(sender:)), for: UIControl.Event.touchDown)
        saveButton.sizeToFit()
        buttonView.addSubview(saveButton)
        
        self.view.addSubview(buttonView)
    }
    @objc func cancelButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @objc func saveButton(sender:UIButton){
        if let presenter = presentingViewController as? LifeViewController5Players {
            presenter.textColor = textInView.textColor
            presenter.backgroundColor = previewView.backgroundColor
        }
        dismiss(animated: true, completion: nil)
    }
}
