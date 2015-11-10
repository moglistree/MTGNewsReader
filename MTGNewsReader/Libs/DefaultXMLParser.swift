//
//  DefaultXMLParser.swift
//  MTGNewsReader
//
//  Created by Martin on 11/4/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class DefaultXMLParser: NSObject, NSXMLParserDelegate {
    
    let item : String = "item"
    // item values
    let title : String = "title"
    let link : String = "link"
    let desc : String = "description"
    let publicationDate : String = "pubDate"
    
    var element : String = ""
    
    var currentItem : DefaultFeedItem? = nil
    
    var data : DefaultChanell? = nil
    
    func parse(response : NSData){
        let parser : NSXMLParser = NSXMLParser(data: response)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if element == title {
            currentItem?.title = (currentItem?.title)! + string
        }
        
        if element == link {
            currentItem?.linkURL = (currentItem?.linkURL)! + string
        }
        
        if element == desc {
            currentItem?.desc = (currentItem?.desc)! + string
        }
        
        if element == publicationDate {
            currentItem?.setPublictionDate(fromString: string)
        }
        
    }
    

    
}
