//
//  SettingsView.swift
//  MTGManager
//
//  Created by Noah Saldaña on 9/4/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

protocol passDataBack {
    func choices(passedTextColor: UIColor!, passedBackgroundColor: UIColor!, passedFontSize: CGFloat!, viewStayOnPassed: Bool!)
}
class SettingsView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var textCollectionView: UICollectionView!
    @IBOutlet weak var dividerCollectionView: UICollectionView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var textInView: UILabel!
    @IBOutlet weak var dividerInView1: UIView!
    @IBOutlet weak var dividerInView2: UIView!
    
    var arrayOfColors: [UIColor] = [.red, .black, .blue, .gray, .darkGray, .brown, .cyan, .green, .magenta, .orange]
    var holderColor: UIColor = .red
    var previewFontSize: CGFloat = 75.0
    var viewStayOn: Bool! = false
    
    let backgroundCollectionViewIndentifier = "backgroundCollection"
    let textCollectionViewIdentifier = "textCollection"
    let dividerCollectionViewIdentifier = "dividerCollection"
    
    var passDataBackDelegate: passDataBack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackButton()
        loadSaveButton()
        loadCollections()
        previewView.backgroundColor = .red
        dividerInView2.backgroundColor = .gray
        dividerInView1.backgroundColor = .gray
    }
    @IBAction func viewStayOnChanged(_ sender: UISwitch) {
        if(sender.isOn == true){
            viewStayOn = true
        }
        else if (sender.isOn == false){
            viewStayOn = false
        }
    }
    @IBAction func fontChanged(_ sender: UISlider) {
        previewFontSize = CGFloat(sender.value)
        textInView.font = UIFont(name:"HelveticaNeue-Bold", size: previewFontSize/2.5)
    }
    override func viewWillAppear(_ animated: Bool) {
        textInView.font = UIFont(name:"HelveticaNeue-Bold", size: previewFontSize/2.5)
    }
    func loadCollections(){
        backgroundCollectionView.dataSource = self
        backgroundCollectionView.delegate = self
        textCollectionView.dataSource = self
        textCollectionView.delegate = self
        dividerCollectionView.dataSource = self
        dividerCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.backgroundCollectionView{
            return arrayOfColors.count
        }
        else if collectionView == self.textCollectionView{
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
            
        else if (collectionView == self.textCollectionView){
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: textCollectionViewIdentifier, for: indexPath) as UICollectionViewCell
            let colorView = UIButton(frame: cellB.contentView.frame)
            colorView.backgroundColor = arrayOfColors[indexPath.row]
            colorView.tag = indexPath.row
            colorView.addTarget(self, action: #selector(textColor(sender:)), for: UIControl.Event.touchDown)
            cellB.addSubview(colorView)
            
            return cellB
        }
        else{
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: dividerCollectionViewIdentifier, for: indexPath) as UICollectionViewCell
            let colorView = UIButton(frame: cellC.contentView.frame)
            colorView.backgroundColor = arrayOfColors[indexPath.row]
            colorView.tag = indexPath.row
            colorView.addTarget(self, action: #selector(dividerColor(sender:)), for: UIControl.Event.touchDown)
            cellC.addSubview(colorView)
            
            return cellC
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
    @objc func dividerColor(sender: UIButton){
        let holderColor = arrayOfColors[sender.tag]
        dividerInView1.backgroundColor = holderColor
        dividerInView2.backgroundColor = holderColor
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
        passDataBackDelegate.choices(passedTextColor: textInView.textColor, passedBackgroundColor: previewView.backgroundColor, passedFontSize: previewFontSize, viewStayOnPassed: viewStayOn)
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

