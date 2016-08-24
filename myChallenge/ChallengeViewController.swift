//
//  ChallengeViewControllr.swift
//  myChallenge
//
//  Created by iMac on 10.08.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CoreData
import Firebase

class ChallengeViewController: UIViewController, UITextFieldDelegate {
    //uiView
    @IBOutlet var viewNameChallenge: UIView!
    let nameTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 240, 45))
    @IBOutlet var viewDateChallege: UIView!
    let dateTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 240, 45))
    @IBOutlet var viewDistanceChallenge: UIView!
    let distlTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 240, 45))
    
    
    @IBOutlet var viewButtonSave: UIButton!
    @IBOutlet var viewButtonCancel: UIButton!
    @IBOutlet var viewButtonDelete: UIButton!
    //logival
    var challengeCell:ChallengeObj?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hidde navigation bar
        self.navigationController?.navigationBarHidden = true
        createUIviewLabel()//draw label
        //
        //        createListTypeAction()//add pickerView
        redrawButtonSave()
        redrawButtonCancel()
        redrawButtonDelete()
        //
        // Do any additional setup after loading the view.
        if challengeCell != nil {
            nameTextFieldSky.text = challengeCell?.name
            dateTextFieldSky.text = DBInspector.sharedInstance.convertTimeDateString(challengeCell?.date).utc
            distlTextFieldSky.text = challengeCell?.dist
        }
    }
    
    // MARK: - UILabel
    func createUIviewLabel(){
        
        
        //name
        
        nameTextFieldSky.placeholder = "Enter name"
        nameTextFieldSky.title = "Challenge's name"
        nameTextFieldSky.errorColor = UIColor.redColor()
        nameTextFieldSky.delegate = self
        
        nameTextFieldSky.tintColor = GlobalType.overcastBlueColor // the color of the blinking cursor
        nameTextFieldSky.textColor = GlobalType.darkGreyColor
        nameTextFieldSky.lineColor = GlobalType.lightGreyColor
        nameTextFieldSky.selectedTitleColor = GlobalType.overcastBlueColor
        nameTextFieldSky.selectedLineColor = GlobalType.overcastBlueColor
        
        nameTextFieldSky.lineHeight = 1.0 // bottom line height in points
        nameTextFieldSky.selectedLineHeight = 2.0
        nameTextFieldSky.tag = 11
        
        self.viewNameChallenge.addSubview(nameTextFieldSky)
        
        //date
        
        dateTextFieldSky.placeholder = "Enter date"
        dateTextFieldSky.title = "Date start"
        dateTextFieldSky.errorColor = UIColor.redColor()
        dateTextFieldSky.delegate = self
        
        dateTextFieldSky.tintColor = GlobalType.overcastBlueColor // the color of the blinking cursor
        dateTextFieldSky.textColor = GlobalType.darkGreyColor
        dateTextFieldSky.lineColor = GlobalType.lightGreyColor
        dateTextFieldSky.selectedTitleColor = GlobalType.overcastBlueColor
        dateTextFieldSky.selectedLineColor = GlobalType.overcastBlueColor
        
        dateTextFieldSky.lineHeight = 1.0 // bottom line height in points
        dateTextFieldSky.selectedLineHeight = 2.0
        dateTextFieldSky.tag = 12
        
        self.viewDateChallege.addSubview(dateTextFieldSky)
        
        
        //dist
        
        distlTextFieldSky.placeholder = "Enter distance"
        distlTextFieldSky.title = "Distance"
        distlTextFieldSky.errorColor = UIColor.redColor()
        distlTextFieldSky.delegate = self
        distlTextFieldSky.keyboardType = .DecimalPad
        
        distlTextFieldSky.tintColor = GlobalType.overcastBlueColor // the color of the blinking cursor
        distlTextFieldSky.textColor = GlobalType.darkGreyColor
        distlTextFieldSky.lineColor = GlobalType.lightGreyColor
        distlTextFieldSky.selectedTitleColor = GlobalType.overcastBlueColor
        distlTextFieldSky.selectedLineColor = GlobalType.overcastBlueColor
        
        distlTextFieldSky.lineHeight = 1.0 // bottom line height in points
        distlTextFieldSky.selectedLineHeight = 2.0
        distlTextFieldSky.tag = 13
        
        self.viewDistanceChallenge.addSubview(distlTextFieldSky)
        
        
    }
    /// Implementing a method on the UITextFieldDelegate protocol. This will notify us when something has changed on the textfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if floatingLabelTextField.tag == 11 { //name
                    if range.location + string.characters.count  < 3 {
                        floatingLabelTextField.errorMessage = "Name so small"
                    }
                    else {
                        // The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                    }
                }  else  if floatingLabelTextField.tag == 13 { //distance
                    if    (text + string as NSString).doubleValue  < 0.3 {
                        floatingLabelTextField.errorMessage = "Distance so short"
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
            if floatingLabelTextField.tag == 12 {
                let datePickerView:UIDatePicker = UIDatePicker()
                datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
                floatingLabelTextField.inputView = datePickerView
                datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
                
            }
        }
        
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let textDate = dateFormatter.stringFromDate(sender.date)
        dateTextFieldSky.text = textDate
        
        //cheack value
        
        if( dateTextFieldSky.text!.characters.count < 10 ) {
            dateTextFieldSky.errorMessage = "Set date"
        } else if fromStringToDate(textDate)?.compare(NSDate(timeIntervalSinceNow:600)) == .OrderedAscending  {
            dateTextFieldSky.errorMessage = "Date so early"
        }
        else {
            // The error message will only disappear when we reset it to nil or empty string
            dateTextFieldSky.errorMessage = ""
        }
        
    }
    func fromStringToDate(stringDate:String?)->NSDate?{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.dateFromString(stringDate!)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {// called when 'return' key pressed. return NO to ignore.{
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK: - button Go
    func redrawButtonSave(){
        self.viewButtonSave.layer.cornerRadius = 0.5 * self.viewButtonSave.bounds.size.width
        self.viewButtonSave.clipsToBounds = true
        self.viewButtonSave.tintColor = GlobalType.overcastBlueColor
        self.viewButtonSave.setTitleColor(GlobalType.overcastBlueColor, forState: UIControlState.Normal)
        self.viewButtonSave.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
    //MARK: - button cancel
    func redrawButtonCancel(){
        self.viewButtonCancel.layer.cornerRadius = 0.5 * self.viewButtonCancel.bounds.size.width
        self.viewButtonCancel.clipsToBounds = true
        self.viewButtonCancel.tintColor = GlobalType.YellowColor
        self.viewButtonCancel.setTitleColor(GlobalType.YellowColor, forState: UIControlState.Normal)
        self.viewButtonCancel.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
    //MARK: - button delete
    func redrawButtonDelete(){
        self.viewButtonDelete.layer.cornerRadius = 0.5 * self.viewButtonDelete.bounds.size.width
        self.viewButtonDelete.clipsToBounds = true
        self.viewButtonDelete.tintColor = GlobalType.RedColor
        self.viewButtonDelete.setTitleColor(GlobalType.RedColor, forState: UIControlState.Normal)
        self.viewButtonDelete.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
    
    @IBAction func tapViewGlobal(sender: AnyObject) {
        if self.nameTextFieldSky.isFirstResponder() {
            self.nameTextFieldSky.resignFirstResponder()
        }
        if self.dateTextFieldSky.isFirstResponder() {
            self.dateTextFieldSky.resignFirstResponder()
        }
        if self.distlTextFieldSky.isFirstResponder() {
            self.distlTextFieldSky.resignFirstResponder()
        }
    }
    
    // MARK: - Validating the fields when "DELETE" is pressed
    
    
    @IBAction func actionDelete(sender: AnyObject) {
        
        if challengeCell !== nil{ //if not new challenge
            DBInspector.sharedInstance.removeFromFireBase(challengeCell!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Validating the fields when "SAVE" is pressed
    @IBAction func actionCancel(sender: AnyObject) {
        print("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func savetoBD(){
        
        var uid = "";
        if let user = FIRAuth.auth()?.currentUser {
            uid = user.uid;
        } else {
            print("You have a problem")
            return
        }
        
        if challengeCell == nil {
            challengeCell = ChallengeObj()
            challengeCell!.ownId = uid
        }
        challengeCell!.name = self.nameTextFieldSky.text!
        challengeCell!.date = DBInspector.sharedInstance.convertTimeStringDate(self.dateTextFieldSky.text!)
        challengeCell!.dist = self.distlTextFieldSky.text!
        
        DBInspector.sharedInstance.upLoadToFireBase(challengeCell!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var isSaveButtonPressed = false
    var showingTitleInProgress = false
    
    @IBAction func saveTouchUpInside(sender: AnyObject) {
        self.isSaveButtonPressed = false
        if(!self.showingTitleInProgress) {
            self.hideTitleVisibleFromFields()
        }
    }
    
    @IBAction func saveDown(sender: AnyObject) {
        self.isSaveButtonPressed = true
        if !self.nameTextFieldSky.hasText() {
            self.showingTitleInProgress = true
            self.nameTextFieldSky.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.nameTextFieldSky.highlighted = true
        }
        if !self.dateTextFieldSky.hasText() {
            self.showingTitleInProgress = true
            self.dateTextFieldSky.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.dateTextFieldSky.highlighted = true
        }
        if !self.distlTextFieldSky.hasText() {
            self.showingTitleInProgress = true
            self.distlTextFieldSky.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
            self.distlTextFieldSky.highlighted = true
        }
        
        // go next step action
        
        
        guard self.nameTextFieldSky.text!.characters.count >= 3  else { return }
        guard self.dateTextFieldSky.text!.characters.count >= 10  else { return }
        guard fromStringToDate(dateTextFieldSky.text)?.compare(NSDate(timeIntervalSinceNow:600)) != .OrderedAscending  else { return }
        guard (self.distlTextFieldSky.text! as NSString).doubleValue  >= 0.3  else { return }
        savetoBD()
    }
    
    func hideTitleVisibleFromFields() {
        self.nameTextFieldSky.setTitleVisible(false, animated: true)
        self.dateTextFieldSky.setTitleVisible(false, animated: true)
        self.distlTextFieldSky.setTitleVisible(false, animated: true)
        
        self.nameTextFieldSky.highlighted = false
        self.dateTextFieldSky.highlighted = false
        self.distlTextFieldSky.highlighted = false
    }
    func showingTitleInAnimationComplete() {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        let displayTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
        dispatch_after(displayTime, dispatch_get_main_queue(), {
            self.showingTitleInProgress = false
            if(!self.isSaveButtonPressed) {
                self.hideTitleVisibleFromFields()
            }
        })
    }
    
}
