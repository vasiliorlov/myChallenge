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
    
    @IBOutlet var tableViewUsers: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //draw label 
        if let challenge = challengeCell {
            self.labelName.text = challenge.name
            self.labelDist.text = challenge.dist! + " km"
            self.labelDate.text = challenge.date
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionBackToList(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

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

}
