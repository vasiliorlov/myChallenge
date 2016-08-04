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


class SignInViewController: UIViewController, UITextFieldDelegate {


    
    
    @IBOutlet var viewEmailLabel: UIView!
    @IBOutlet var viewPasswordLabel: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUIviewLabel()//draw label

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
    @IBAction func createNewUser(sender: AnyObject) {

        
   //                 FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                // ...
                
               print("crete user")
        
        
    }
    
    
     // MARK: - UILabel
    func createUIviewLabel(){
        //color
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        
        //email - login
        
        let emailTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 220, 45))
        emailTextFieldSky.placeholder = "Email (login)"
        emailTextFieldSky.title = "Email address"
        emailTextFieldSky.errorColor = UIColor.redColor()
        emailTextFieldSky.delegate = self
        
        emailTextFieldSky.tintColor = overcastBlueColor // the color of the blinking cursor
        emailTextFieldSky.textColor = darkGreyColor
        emailTextFieldSky.lineColor = lightGreyColor
        emailTextFieldSky.selectedTitleColor = overcastBlueColor
        emailTextFieldSky.selectedLineColor = overcastBlueColor
        
        emailTextFieldSky.lineHeight = 1.0 // bottom line height in points
        emailTextFieldSky.selectedLineHeight = 2.0
        emailTextFieldSky.tag = 1
      
        self.viewEmailLabel.addSubview(emailTextFieldSky)
        
        //password - login
        let passlTextFieldSky = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 220, 45))
        passlTextFieldSky.placeholder = "Password"
        passlTextFieldSky.title = "Your password"
        passlTextFieldSky.errorColor = UIColor.redColor()
        passlTextFieldSky.delegate = self
        
        passlTextFieldSky.tintColor = overcastBlueColor // the color of the blinking cursor
        passlTextFieldSky.textColor = darkGreyColor
        passlTextFieldSky.lineColor = lightGreyColor
        passlTextFieldSky.selectedTitleColor = overcastBlueColor
        passlTextFieldSky.selectedLineColor = overcastBlueColor
        
        passlTextFieldSky.lineHeight = 1.0 // bottom line height in points
        passlTextFieldSky.selectedLineHeight = 2.0
        passlTextFieldSky.tag = 2
        
        self.viewPasswordLabel.addSubview(passlTextFieldSky)
        
        
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
                        floatingLabelTextField.errorMessage = "Password so easy "
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
    
}
