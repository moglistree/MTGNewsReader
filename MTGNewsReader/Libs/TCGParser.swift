//
//  TCGParser.swift
//  MTGNewsReader
//
//  Created by Martin on 11/3/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class TCGParser: NSObject, NSXMLParserDelegate {
    
    let item : String = "item"
    // item values
    let title : String = "title"
    let link : String = "link"
    let desc : String = "description"
    let creator : String = "author"
    
    var element : String = ""
    
    var currentItem : TCGItem? = nil
    var data : TCGChanell = TCGChanell()
    
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
            
            currentItem = TCGItem()
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "      "{
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
        
        if element == creator {
            currentItem?.creator = (currentItem?.creator)! + string
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
}
