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
            lblDescription.text = getAtributedString(fromHtml: object.desc)
        }
    }
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblCreator : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    
    func getAtributedString(fromHtml html: String) -> String{
        let encodedData = html.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        
        do {
           let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)

            return attributedString.string
        } catch {
            print(error)
            return ""
        }
        
    }

}
