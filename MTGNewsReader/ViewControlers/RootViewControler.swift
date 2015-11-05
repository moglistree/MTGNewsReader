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
    
    var refreshControl:UIRefreshControl!
    
    var items : [DefaultFeedItem] = []
    var selectedItem : DefaultFeedItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        confgiTableView()
        
        getData()
        
    }
    
    func getData(){
        
        DataStore.sharedInstance.getHomeScreenData { (items) -> () in
            self.items = items
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    func confgiTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("getData"), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedCell
        
        cell.object = self.items[indexPath.row]
        
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
