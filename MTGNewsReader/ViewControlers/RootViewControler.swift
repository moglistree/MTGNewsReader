//
//  RootViewControler.swift
//  MTGNewsReader
//
//  Created by Martin on 10/28/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class RootViewControler: UIViewController {
    
    let CHFBFeed : NSURL = NSURL(string: "http://www.channelfireball.com/feed/")!
    let TCGFeed : NSURL = NSURL(string: "http://www.tcgplayer.com/rss/rssfeed.xml")!
    let SCGFeed : NSURL = NSURL(string: "http://www.starcitygames.com/rss/rssfeed.xml")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(CHFBFeed) {(data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            
            let responseParser = CHFBXMLParser()
            responseParser.parse(data!)
        }
        
        task.resume()
        
    }
    
}
