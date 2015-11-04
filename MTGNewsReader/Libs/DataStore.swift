//
//  DataStore.swift
//  MTGNewsReader
//
//  Created by Martin on 11/4/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class DataStore: NSObject {

    let CHFBFeed : NSURL = NSURL(string: "http://www.channelfireball.com/feed/")!
    let TCGFeed : NSURL = NSURL(string: "http://www.tcgplayer.com/rss/rssfeed.xml")!
    let SCGFeed : NSURL = NSURL(string: "http://www.starcitygames.com/rss/rssfeed.xml")!
    
    func getHomeScreenData(completionClosure : (items : [DefaultFeedItem]) -> ()){
        var scgFinished = false
        var chfbFinished = false
        var tcgFinished = false
        var allItems : [DefaultFeedItem] = []
        let notyfyMainThreadIfNeeded = ({() -> () in
            if scgFinished && tcgFinished && chfbFinished{
                completionClosure(items: allItems)
            }
        })
        
        getData(fromUrl: CHFBFeed, andXmlParser: CHFBXMLParser(), completionClosure: { (items) -> () in
            allItems = allItems + items
            chfbFinished = true
            notyfyMainThreadIfNeeded()
        })
        
        getData(fromUrl: SCGFeed, andXmlParser: SCGXMLParser(), completionClosure: { (items) -> () in
            allItems = allItems + items
            scgFinished = true
            notyfyMainThreadIfNeeded()
        })
        
        getData(fromUrl: TCGFeed, andXmlParser: TCGXMLParser(), completionClosure: { (items) -> () in
            allItems = allItems + items
            tcgFinished = true
            notyfyMainThreadIfNeeded()
        })
    }
    
    private func getData(fromUrl url : NSURL, andXmlParser responseParser: DefaultXMLParser , completionClosure : (items : [DefaultFeedItem]) -> ()){
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            
            responseParser.parse(data!)
            
            completionClosure(items: responseParser.data!.items)
        }
        
        task.resume()
    }
    
}
