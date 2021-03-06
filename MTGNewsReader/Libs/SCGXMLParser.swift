//
//  SCGXMLParser.swift
//  MTGNewsReader
//
//  Created by Martin on 11/2/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class SCGXMLParser: DefaultXMLParser {
    
    let creator : String = "creator"
    
    var channelDate : String? = nil
    
    override func parse(response : NSData){
        self.data = SCGChanell()
        
        super.parse(response)
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName
        
        if elementName == item {
            if currentItem != nil {
                currentItem?.setPublictionDate(fromString: channelDate!)
                data!.items.append(currentItem!)
            }
            
            currentItem = SCGItem()
        }
        
    }
    
    override func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "\n            " || string == "\n        "{
            return
        }
        
        if element == publicationDate {
            channelDate = string
        }
        
        if element == creator {
            currentItem?.creator = (currentItem?.creator)! + string
        }
        
        super.parser(parser, foundCharacters: string)
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
    
}
