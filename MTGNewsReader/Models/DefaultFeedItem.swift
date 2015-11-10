//
//  DefaultFeedItem.swift
//  MTGNewsReader
//
//  Created by Martin on 11/2/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class DefaultFeedItem: NSObject {

    var title : String = ""
    var creator : String = ""
    var desc : String = ""
    
    private var linkURL : NSURL?
    private var publicatedDate : NSDate?
    
    func setURL(fromString urlString : String){
        if let urlString : String? = urlString {
            if let url = NSURL(string: urlString!) {
                if  UIApplication.sharedApplication().canOpenURL(url) {
                    self.linkURL = url
                    return
                }
            }
        }
        self.linkURL = nil
    }
    
    func setPublictionDate(fromString stringDate : String){
        
        let formater : NSDateFormatter = NSDateFormatter()
        formater.dateFormat = "EEE, dd MM yyyy HH:mm:ss Z"
        
        self.publicatedDate = formater.dateFromString(stringDate)
        
        if self.publicatedDate == nil {
            formater.dateFormat = "EEE, d MM yyyy HH:mm:ss"
            self.publicatedDate = formater.dateFromString(stringDate)
        }
        
    }
    
    func getPublicationDate() -> NSDate{
        return self.publicatedDate!
    }
    
    func getURL () -> NSURL?{
        return linkURL
    }
    
}
