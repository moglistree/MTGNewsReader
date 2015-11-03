//
//  CHFBFeedCell.swift
//  MTGNewsReader
//
//  Created by Martin on 10/29/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    var object : DefaultFeedItem! {
        didSet {
            lblTitle.text = object.title
            if object.creator != "" {
                lblCreator.text = "By: " + object.creator
            } else {
                lblCreator.text = ""
            }
            //lblDescription.attributedText = getAtributedString(fromHtml: object.desc)
        }
    }
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblCreator : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    
    func getAtributedString(fromHtml html: String) -> NSAttributedString?{
        let encodedData = html.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        
        do {
           let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)

            return attributedString
        } catch {
            print(error)
            return nil
        }
        
    }

}
