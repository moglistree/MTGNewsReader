//
//  RootViewControler.swift
//  MTGNewsReader
//
//  Created by Martin on 10/28/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class RootViewControler: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    
    let CHFBFeed : NSURL = NSURL(string: "http://www.channelfireball.com/feed/")!
    let TCGFeed : NSURL = NSURL(string: "http://www.tcgplayer.com/rss/rssfeed.xml")!
    let SCGFeed : NSURL = NSURL(string: "http://www.starcitygames.com/rss/rssfeed.xml")!
    
    var items : Array<CHFBItem> = Array()
    var selectedItem : CHFBItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCHFBData()
        
        getSCGData()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
    }
    
    func getSCGData(){
        let task = NSURLSession.sharedSession().dataTaskWithURL(SCGFeed) {(data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            
            let responseParser = SCGXMLParser()
            responseParser.parse(data!)
            
            self.items += responseParser.data
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        
        task.resume()
    }
    
    func getCHFBData() {
        let task = NSURLSession.sharedSession().dataTaskWithURL(CHFBFeed) {(data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            
            let responseParser = CHFBXMLParser()
            responseParser.parse(data!)
            
            self.items += responseParser.data
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CHFBFeedCell") as! CHFBFeedCell
        
        cell.object = items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedItem = items[indexPath.row]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("showArticle", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let segueIdentifier : String = segue.identifier!
        
        if (segueIdentifier == "showArticle")
        {
            let vc = segue.destinationViewController as! ArticleViewController
            vc.item = selectedItem
        }
        
        selectedItem = nil
        
    }
    
}
