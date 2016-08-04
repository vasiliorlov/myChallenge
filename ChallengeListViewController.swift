//
//  ChallengeListViewController.swift
//  myChallenge
//
//  Created by iMac on 26.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit

class ChallengeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!//challenge list
    var row: Int = 2//DBInspector.sharedInstance.getCountEntity(entity: "Run") + 1 //for button +
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    //UITableViewDataSource
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      return row
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        var cell:UITableViewCell? = nil
        if indexPath.row  < row - 1 {
            cell = self.tableView.dequeueReusableCellWithIdentifier("ChallengeCell", forIndexPath: indexPath) as! ChallengeCell
        }
        if indexPath.row == row - 1 {
             cell =  self.tableView.dequeueReusableCellWithIdentifier("AddChallengeCell", forIndexPath: indexPath) as! AddChallengeCell
              //self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
            
        }
        return cell!
    }
    //UITableViewDelegate
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
       if indexPath.row == row - 1 {
         row += 1
         tableView.reloadData()
   
        //open run controller
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NewRunViewController") as! NewRunViewController
        self.presentViewController(vc, animated: true, completion: nil)

        
        }
    }
}
