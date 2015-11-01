//
//  CHFBFeedCell.swift
//  MTGNewsReader
//
//  Created by Martin on 10/29/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class CHFBFeedCell: UITableViewCell {

    var object :CHFBItem! {
        didSet {
            lblTitle.text = object.title
            lblCreator.text = object.creator
            lblDescription.text = object.desc
        }
    }
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblCreator : UILabel!
    @IBOutlet weak var lblDescription : UILabel!

}
