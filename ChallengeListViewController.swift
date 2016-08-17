//
//  ChallengeListViewController.swift
//  myChallenge
//
//  Created by iMac on 26.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit

class ChallengeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ButtonCellDelegate,DBInspetorDelegateListChallenge  {
    
    @IBOutlet var tableView: UITableView!//challenge list
    
    var challenges:[ChallengeObj]?
    var row: Int = 1
    
    //refresh from firebase
    var refreshControl:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBInspector.sharedInstance.dbInspectorListCh = self //delegate refresh
        refreshControllerCreate()//refreshControll
        //update view
        DBInspector.sharedInstance.downloadNoneMyChallenge()
        
        


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //scan list change and reload table
    func reloadList(){
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func reloadChallenge(challenges: [ChallengeObj]?) {

        if challenges != nil {
            self.challenges = challenges
            self.row        = challenges!.count + 1
        }
        reloadList()
        self.refreshControl.endRefreshing()
    }
    
    
    //refresh firebase
    func refreshControllerCreate(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: GlobalType.refreshFireBase)
        refreshControl.tintColor = GlobalType.lightGreyColor
        refreshControl.addTarget(self, action: #selector(ChallengeListViewController.reloadManual(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //update from firebase
    func reloadManual(sender:AnyObject) {
             DBInspector.sharedInstance.downloadNoneMyChallenge()
    }
    
    //UITableViewDataSource
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return row
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.row  < row - 1 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ChallengeCell", forIndexPath: indexPath) as! ChallengeCell
            cell.challengeCell = challenges![indexPath.row]
            cell.label.text = challenges![indexPath.row].id
            cell.buttonDelegate = self
            return cell
        }
        else  {
            let cell =  self.tableView.dequeueReusableCellWithIdentifier("AddChallengeCell", forIndexPath: indexPath) as! AddChallengeCell
            return cell
        }
        
        
    }
    //UITableViewDelegate
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == row - 1 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeViewController") as! ChallengeViewController
            vc.challengeCell = nil
            self.presentViewController(vc, animated:true, completion:nil)
        } else {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeDetailViewController") as! ChallengeDetailViewController
                vc.challengeCell = challenges![indexPath.row]
            self.presentViewController(vc, animated:true, completion:nil)

        }
    }
    //go setting action
    func cellTapped(cell: ChallengeCell){
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeViewController") as! ChallengeViewController
        vc.challengeCell = cell.challengeCell
        self.presentViewController(vc, animated:true, completion:nil)
    }
    
    
}
