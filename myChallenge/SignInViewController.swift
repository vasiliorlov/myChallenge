//
//  SignInViewController.swift
//  myChallenge
//
//  Created by iMac on 30.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit
import FirebaseAuth
import SkyFloatingLabelTextField

class SignInViewController: UIViewController, UITextFieldDelegate, AKPickerViewDelegate, AKPickerViewDataSource  {
    
    
    
    
    @IBOutlet var viewEmailLabel: UIView!
    let emailTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 240, 45))
    @IBOutlet var viewPasswordLabel: UIView!
    let passTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 240, 45))
    @IBOutlet var viewTypePicker: UIView!
    @IBOutlet var viewButtonGo: UIButton!
    
    var currentActionType = 1 {
        didSet {
            if currentActionType == 0 { //remember pass
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.viewPasswordLabel.alpha = 0
                    }, completion: { (finished: Bool) -> Void   in
                        self.viewPasswordLabel.hidden = true
                })
            } else if oldValue == 0 {
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.viewPasswordLabel.alpha = 1
                    }, completion: { (finished: Bool) -> Void   in
                        self.viewPasswordLabel.hidden = false
                })
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUIviewLabel()//draw label
        createListTypeAction()//add pickerView
        redrawButtonGo()//redraw button
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: - UILabel
    func createUIviewLabel(){
        //color
        
        
        
        //email - login
        
        emailTextFieldSky.placeholder = "Email (login)"
        emailTextFieldSky.title = "Email address"
        emailTextFieldSky.errorColor = UIColor.redColor()
        emailTextFieldSky.delegate = self
        
        emailTextFieldSky.tintColor = GlobalType.overcastBlueColor // the color of the blinking cursor
        emailTextFieldSky.textColor = GlobalType.darkGreyColor
        emailTextFieldSky.lineColor = GlobalType.lightGreyColor
        emailTextFieldSky.selectedTitleColor = GlobalType.overcastBlueColor
        emailTextFieldSky.selectedLineColor = GlobalType.overcastBlueColor
        
        emailTextFieldSky.lineHeight = 1.0 // bottom line height in points
        emailTextFieldSky.selectedLineHeight = 2.0
        emailTextFieldSky.tag = 1
        
        self.viewEmailLabel.addSubview(emailTextFieldSky)
        
        //password - login
        
        passTextFieldSky.placeholder = "Password"
        passTextFieldSky.title = "Your password"
        passTextFieldSky.errorColor = UIColor.redColor()
        passTextFieldSky.delegate = self
        
        passTextFieldSky.tintColor = GlobalType.overcastBlueColor // the color of the blinking cursor
        passTextFieldSky.textColor = GlobalType.darkGreyColor
        passTextFieldSky.lineColor = GlobalType.lightGreyColor
        passTextFieldSky.selectedTitleColor = GlobalType.overcastBlueColor
        passTextFieldSky.selectedLineColor = GlobalType.overcastBlueColor
        
        passTextFieldSky.lineHeight = 1.0 // bottom line height in points
        passTextFieldSky.selectedLineHeight = 2.0
        passTextFieldSky.tag = 2
        
        self.viewPasswordLabel.addSubview(passTextFieldSky)
        
        
    }
    /// Implementing a method on the UITextFieldDelegate protocol. This will notify us when something has changed on the textfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if floatingLabelTextField.tag == 1 { //email
                    if(text.characters.count < 5 || !text.containsString("@")  || !text.containsString(".")) {
                        floatingLabelTextField.errorMessage = "Invalid email"
                    }
                    else {
                        // The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                    }
                } else if floatingLabelTextField.tag == 2 {//password
                    if(text.characters.count < 6 ) {
                        floatingLabelTextField.errorMessage = "Password so easy"
                    }
                    else {
                        // The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                    }
                }
                
                
            }
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {// called when 'return' key pressed. return NO to ignore.{
        
        textField.resignFirstResponder()
        
        return true
    }
    //MARK: -  picker action type
    func createListTypeAction(){
        
        let pickerView = AKPickerView(frame: CGRectMake(10, 10, 240, 45))
        pickerView.selectedItem = 1
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        pickerView.textColor = GlobalType.lightGreyColor
        pickerView.highlightedTextColor = GlobalType.overcastBlueColor
        pickerView.pickerViewStyle = .Wheel
        pickerView.maskDisabled = true
        pickerView.reloadData()
        self.viewTypePicker.addSubview(pickerView)
        
    }
    //MARK: - data picker delegate
    
    
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return GlobalType.typeActionEn.count
    }
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return GlobalType.typeActionEn[item]
    }
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        self.currentActionType = item
        
    }
    
    //MARK: - button Go
    func redrawButtonGo(){
        self.viewButtonGo.layer.cornerRadius = 0.5 * self.viewButtonGo.bounds.size.width
        self.viewButtonGo.clipsToBounds = true
        self.viewButtonGo.tintColor = GlobalType.overcastBlueColor
        self.viewButtonGo.setTitleColor(GlobalType.overcastBlueColor, forState: UIControlState.Normal)
        self.viewButtonGo.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
        
        
    }
    // MARK: - Validating the fields when "GO" is pressed
    var isGOButtonPressed = false
    var showingTitleInProgress = false
    
    @IBAction func actionButtonGo(sender: AnyObject) {
        self.isGOButtonPressed = false
        if(!self.showingTitleInProgress) {
            self.hideTitleVisibleFromFields()
        }
    }
    
    @IBAction func actionButtonGoDown(sender: AnyObject) {
        self.isGOButtonPressed = true
        if !self.emailTextFieldSky.hasText() {
            self.showingTitleInProgress = true
            self.emailTextFieldSky.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.emailTextFieldSky.highlighted = true
        }
        if !self.passTextFieldSky.hasText() {
            self.showingTitleInProgress = true
            self.passTextFieldSky.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.passTextFieldSky.highlighted = true
        }
        
        // go next step action
        guard self.emailTextFieldSky.hasText() else { return }
        guard self.passTextFieldSky.hasText() else { return }
        guard self.emailTextFieldSky.text!.characters.count >= 5 && self.emailTextFieldSky.text!.containsString("@")  && self.emailTextFieldSky.text!.containsString(".") else { return }
        guard self.passTextFieldSky.text!.characters.count >= 6  else { return }
        
        //goAction()
    }
    func hideTitleVisibleFromFields() {
        self.emailTextFieldSky.setTitleVisible(false, animated: true)
        self.passTextFieldSky.setTitleVisible(false, animated: true)
        
        self.emailTextFieldSky.highlighted = false
        self.passTextFieldSky.highlighted = false
    }
    func showingTitleInAnimationComplete() {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        let displayTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
        dispatch_after(displayTime, dispatch_get_main_queue(), {
            self.showingTitleInProgress = false
            if(!self.isGOButtonPressed) {
                self.hideTitleVisibleFromFields()
            }
        })
    }
    
    // MARK: - Go next step action
    
    func goAction(){
        switch currentActionType {
        case 0:
            print("remember")
        case 1:
            print("Log In")
        case 2:
            print("Create user")
        default:
            return
        }
    }
    //create user
    func createNewUser(sender: AnyObject) {
       // FIRAuth.auth()?.createUserWithEmail(self.emailTextFieldSky.text!, password: self.passTextFieldSky.text!) { (user, error) in       }
    }
}

