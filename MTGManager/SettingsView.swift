//
//  SettingsView.swift
//  MTGManager
//
//  Created by Noah Saldaña on 9/4/19.
//  Copyright © 2019 Noah Saldaña. All rights reserved.
//

import UIKit

protocol passDataBack {
    func choices(passedDividerColor: UIColor!, passedTextColor: UIColor!, passedBackgroundColor: UIColor!, passedFontSize: CGFloat!, viewStayOnPassed: Bool!)
}
class SettingsView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var textCollectionView: UICollectionView!
    @IBOutlet weak var dividerCollectionView: UICollectionView!
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var textInView: UILabel!
    @IBOutlet weak var dividerInView1: UIView!
    @IBOutlet weak var dividerInView2: UIView!
    
    @IBOutlet weak var textSizeSlider: UISlider!
    @IBOutlet weak var keepScreenOnSwitch: UISwitch!
    
    var arrayOfColors: [UIColor] = [.red, .black, .blue, .gray, .darkGray, .brown, .cyan, .green, .magenta, .orange]
    var textColor: UIColor! = UIColor(red: 32/255, green: 178/255, blue: 170/255, alpha: 1)
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
        refresh()
    }
    @IBAction func viewStayOnChanged(_ sender: UISwitch) {
        if(sender.isOn == true){
            viewStayOn = true
            UserDefaults.standard.set(true, forKey: "keepScreenOn")
        }
        else if (sender.isOn == false){
            viewStayOn = false
            UserDefaults.standard.set(false, forKey: "keepScreenOn")
        }
    }
    @IBAction func fontChanged(_ sender: UISlider) {
        previewFontSize = CGFloat(sender.value)
        textInView.font = UIFont(name:"HelveticaNeue-Bold", size: previewFontSize/2.5)
    }
    override func viewWillAppear(_ animated: Bool) {
        refresh()
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
    func refresh(){
        if (UserDefaults.standard.bool(forKey: "keepScreenOn")){
            keepScreenOnSwitch.isOn = true
        }
        else{
            keepScreenOnSwitch.isOn = false
        }
        textSizeSlider.value = UserDefaults.standard.float(forKey: "fontSize")
        previewView.backgroundColor = UserDefaults.standard.color(forKey: "previewView")
        previewFontSize = CGFloat(UserDefaults.standard.integer(forKey: "fontSize"))
        textInView.textColor = UserDefaults.standard.color(forKey: "textColor")
        dividerInView1.backgroundColor = UserDefaults.standard.color(forKey: "dividerColor")
        dividerInView2.backgroundColor = UserDefaults.standard.color(forKey: "dividerColor")
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
        passDataBackDelegate.choices(passedDividerColor: dividerInView1.backgroundColor,passedTextColor: textInView.textColor, passedBackgroundColor: previewView.backgroundColor, passedFontSize: previewFontSize, viewStayOnPassed: viewStayOn)
        UserDefaults.standard.set(dividerInView1.backgroundColor, forKey: "dividerColor")
        UserDefaults.standard.set(textInView.textColor, forKey: "textColor")
        UserDefaults.standard.set(previewView.backgroundColor, forKey: "previewView")
        UserDefaults.standard.set(previewFontSize, forKey: "fontSize")
        dismiss(animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UserDefaults {
    
    func color(forKey key: String) -> UIColor? {
        
        guard let colorData = data(forKey: key) else { return nil }
        
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("color error \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func set(_ value: UIColor?, forKey key: String) {
        
        guard let color = value else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error color key data not saved \(error.localizedDescription)")
        }
        
    }
    
}
