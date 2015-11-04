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
    var linkURL : String = ""
    var creator : String = ""
    var desc : String = ""
    
    private var publicatedDate : NSDate?
    
    func setPublictionDate(fromString stringDate : String){
        
        let formater : NSDateFormatter = NSDateFormatter()
        formater.dateFormat = "EEE, yyyy MM dd HH:mm:ss Z"
        
        self.publicatedDate = formater.dateFromString(stringDate)
        
    }
    
}
