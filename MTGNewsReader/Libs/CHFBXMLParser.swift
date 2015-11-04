//
//  CHFBXMLParser.swift
//  MTGNewsReader
//
//  Created by Martin on 10/28/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class CHFBXMLParser: DefaultXMLParser{
    
    let comments : String = "comments"
    let publicationDate : String = "pubDate"
    let creator : String = "dc:creator"
    let category : String = "category"
    let guid : String = "guid"
    let commentsRss : String = "wfw:commentRss"
    let commentsNumber : String = "slash:comments"
    
    override func parse(response : NSData){
        self.data = CHFBChannell()
        
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
            
            currentItem = CHFBItem()
        }
        
    }
    
    override func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "\n\t\t" || string == "\n\t\t\t" || string == "\n\t\t\t\t"{
            return
        }
        
        super.parser(parser, foundCharacters: string)
        
        if element == comments {
            (currentItem as! CHFBItem).commentsURL = (currentItem as! CHFBItem).commentsURL + string
        }
        
        if element == publicationDate {
            (currentItem as! CHFBItem).setPublictionDate(fromString: string)
        }
        
        if element == creator {
             currentItem?.creator = (currentItem?.creator)! + string
        }
        
        if element == category {
            (currentItem as! CHFBItem).categories.append(string)
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
    
}
