//
//  CHFBXMLParser.swift
//  MTGNewsReader
//
//  Created by Martin on 10/28/15.
//  Copyright © 2015 Martin. All rights reserved.
//

protocol CHFBXMLParserDelegate {
    
}

import UIKit

class CHFBXMLParser: NSObject, NSXMLParserDelegate {
    
    let item : String = "item"
    // item values
    let title : String = "title"
    let link : String = "link"
    let comments : String = "comments"
    let publicationDate : String = "pubDate"
    let desc : String = "description"
    let creator : String = "dc:creator"
    let category : String = "category"
    let guid : String = "guid"
    let commentsRss : String = "wfw:commentRss"
    let commentsNumber : String = "slash:comments"
    
    var element : String = ""
    
    var currentItem : CHFBItem? = nil
    var data : Array<CHFBItem> = Array()
    
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
                data.append(currentItem!)
            }
            
            currentItem = CHFBItem()
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if string == "\n\t\t" {
            return
        }
        
        if element == title {
            currentItem?.title = (currentItem?.title)! + string
        }
        
        if element == link {
            currentItem?.linkURL = (currentItem?.linkURL)! + string
        }
        
        if element == comments {
            currentItem?.commentsURL = (currentItem?.commentsURL)! + string
        }
        
        if element == publicationDate {
            currentItem?.publicatedDate = (currentItem?.publicatedDate)! + string
        }
        
        if element == desc {
            currentItem?.desc = (currentItem?.desc)! + string
        }
        
        if element == creator {
            currentItem?.creator = (currentItem?.creator)! + string
        }
        
        if element == category {
            currentItem?.categories.append(string)
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
    
}
