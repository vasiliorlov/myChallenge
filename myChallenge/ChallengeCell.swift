//
//  ChallengeCell.swift
//  myChallenge
//
//  Created by iMac on 27.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate {
    func cellTapped(cell: ChallengeCell)
}

class ChallengeCell: UITableViewCell {

    var buttonDelegate:ButtonCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionButtonSetting(sender: AnyObject) {
        if let delegate = buttonDelegate {
            delegate.cellTapped(self)
        }
    }

}
