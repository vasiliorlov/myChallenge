//
//  AccountViewController.swift
//  myChallenge
//
//  Created by iMac on 24.08.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //photo view
    let photoPicker = UIImagePickerController()
    @IBOutlet var photoView: UIImageView!
    /*
     self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
     self.profileImageView.clipsToBounds = YES;
     
     2
     self.profileImageView.layer.borderWidth = 3.0f;
     self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
     self.profileImageView.layer.cornerRadius = 10.0f;
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPicker.delegate = self
        
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
    @IBAction func useCamera(sender: AnyObject) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            photoPicker.allowsEditing = false
            photoPicker.sourceType = .Camera
            presentViewController(photoPicker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error camera", message: "Your device is not found camera", preferredStyle: .Alert) //Your device has no camera
            let OKAction = UIAlertAction(title: "Continue", style: .Default) { (action:UIAlertAction!) in
                print("Error camera")
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
        
    }
    
    @IBAction func useGallery(sender: AnyObject) {
        photoPicker.allowsEditing = false
        photoPicker.sourceType = .PhotoLibrary
        presentViewController(photoPicker, animated: true, completion: nil)
        
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoView.contentMode = .ScaleToFill
            photoView.image = DBInspector.sharedInstance.convertImage(pickedImage)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //action button
    @IBAction func actionSave(sender: AnyObject) {
        if var image = photoView.image {
            image = DBInspector.sharedInstance.convertImage(image)
        DBInspector.sharedInstance.saveImageToFireBase(image)
        }
    }
    
    @IBAction func actionBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
