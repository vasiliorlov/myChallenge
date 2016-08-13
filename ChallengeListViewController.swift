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
    var challenges = DBInspector.sharedInstance.getChallenge(filter.all) //challenge from coredata
    var row: Int = DBInspector.sharedInstance.getChallenge(filter.all).count + 1//DBInspector.sharedInstance.getCountEntity(entity: "Run") + 1 //for button +
   
    //refresh from firebase
    var refreshControl:UIRefreshControl!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControllerCreate()//refreshControll
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadList()
    }
    
    //scan list change and reload table
    func reloadList(){

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })

    }
    func reloadChallenge() {
        reloadList()
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
        sleep(3)
        
        self.refreshControl.endRefreshing()
    }

    //UITableViewDataSource
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return row
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.row  < row - 1 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ChallengeCell", forIndexPath: indexPath) as! ChallengeCell
                cell.challengeCell = challenges[indexPath.row]
                cell.label.text = challenges[indexPath.row].id
            
            if cell.buttonDelegate == nil {
                cell.buttonDelegate = self
            }
            
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
            row += 1
            tableView.reloadData()
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeViewController") as! ChallengeViewController
            vc.challengeCell = nil
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
