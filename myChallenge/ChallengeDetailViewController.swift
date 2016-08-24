//
//  ChallengeDetailViewController.swift
//  myChallenge
//
//  Created by iMac on 16.08.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {
    //logival
    var challengeCell:ChallengeObj?
    //label
    
    @IBOutlet var labelName: UILabel!

    @IBOutlet var labelDist: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelCount: UILabel!
    @IBOutlet var labelPlace: UILabel!
    //uibutton
    
    
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var buttonRunPause: UIButton!
    @IBOutlet var buttonStop: UIButton!
    //table
    @IBOutlet var tableViewUsers: UITableView!
    
    //timer
     lazy var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //uiButton
        redrawButtonRunPause()
        redrawButtonBack()
        redrawButtonStop()
        
        //draw label 
        if let challenge = challengeCell {
            self.labelName.text = challenge.name
            self.labelDist.text = challenge.dist! + " km"
            self.labelDate.text = DBInspector.sharedInstance.convertTimeDateString(challenge.date).utc
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1,
                                                       target: self,
                                                       selector: #selector(NewRunViewController.eachSecond(_:)),
                                                       userInfo: nil,
                                                       repeats: true)
      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionBackToList(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    //MARK: timer
    func eachSecond(timer: NSTimer) {
       
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //UITableViewDataSource
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
//        if indexPath.row  < row - 1 {
            let cell = self.tableViewUsers.dequeueReusableCellWithIdentifier("MiniChallengeCell", forIndexPath: indexPath) as! MiniChallengeCell
//            cell.challengeCell = challenges![indexPath.row]
//            cell.label.text = challenges![indexPath.row].id
//            cell.buttonDelegate = self
//            return cell
//        }
//        else  {
//            let cell =  self.tableView.dequeueReusableCellWithIdentifier("AddChallengeCell", forIndexPath: indexPath) as! AddChallengeCell
            return cell
   //     }
        
        
    }
    //UITableViewDelegate
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        if indexPath.row == row - 1 {
//            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeViewController") as! ChallengeViewController
//            vc.challengeCell = nil
//            self.presentViewController(vc, animated:true, completion:nil)
//        } else {
//            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeDetailViewController") as! ChallengeDetailViewController
//            self.presentViewController(vc, animated:true, completion:nil)
//            
//        }
    }

    
    
    //MARK: - button Run Pause
    func redrawButtonRunPause(){
        self.buttonRunPause.layer.cornerRadius = 0.5 * self.buttonRunPause.bounds.size.width
        self.buttonRunPause.clipsToBounds = true
        self.buttonRunPause.tintColor = GlobalType.overcastBlueColor
        self.buttonRunPause.setTitleColor(GlobalType.overcastBlueColor, forState: UIControlState.Normal)
        self.buttonRunPause.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
    //MARK: - button back
    func redrawButtonBack(){
        self.buttonBack.layer.cornerRadius = 0.5 * self.buttonBack.bounds.size.width
        self.buttonBack.clipsToBounds = true
        self.buttonBack.tintColor = GlobalType.YellowColor
        self.buttonBack.setTitleColor(GlobalType.YellowColor, forState: UIControlState.Normal)
        self.buttonBack.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
    //MARK: - button stop
    func redrawButtonStop(){
        self.buttonStop.layer.cornerRadius = 0.5 * self.buttonStop.bounds.size.width
        self.buttonStop.clipsToBounds = true
        self.buttonStop.tintColor = GlobalType.RedColor
        self.buttonStop.setTitleColor(GlobalType.RedColor, forState: UIControlState.Normal)
        self.buttonStop.setTitleColor(GlobalType.lightGreyColor, forState: UIControlState.Highlighted)
        
    }
}
