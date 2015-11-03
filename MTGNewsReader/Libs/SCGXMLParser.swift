//
//  SCGXMLParser.swift
//  MTGNewsReader
//
//  Created by Martin on 11/2/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class SCGXMLParser: NSObject, NSXMLParserDelegate {

    let item : String = "item"
    // item values
    let title : String = "title"
    let link : String = "link"
    let desc : String = "description"
    
    var element : String = ""
    
    var currentItem : SCGItem? = nil
    var data : SCGChanell = SCGChanell()
    
    func parse(response : NSData){
        let parser : NSXMLParser = NSXMLParser(data: response)
        parser.delegate = self
        parser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName
        
        if elementName == item {
            if currentItem != nil {
                data.items.append(currentItem!)
            }
            
            currentItem = SCGItem()
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "\n            "{
            return
        }
        
        if element == title {
            currentItem?.title = (currentItem?.title)! + string
        }
        
        if element == link {
            currentItem?.linkURL = (currentItem?.linkURL)! + string
        }
        
        if element == desc {
            currentItem?.desc = (currentItem?.desc)! + string
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
    
}
