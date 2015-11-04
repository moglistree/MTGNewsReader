//
//  TCGParser.swift
//  MTGNewsReader
//
//  Created by Martin on 11/3/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class TCGXMLParser: DefaultXMLParser {
    
    let creator : String = "author"
    
    override func parse(response : NSData){
        self.data = TCGChanell()
        
        super.parse(response)
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName
        
        if elementName == item {
            if currentItem != nil {
                data!.items.append(currentItem!)
            }
            
            currentItem = TCGItem()
        }
        
    }
    
    override func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "      "{
            return
        }
        
        if element == creator {
            currentItem?.creator = (currentItem?.creator)! + string
        }
        
        super.parser(parser, foundCharacters: string)
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
}
