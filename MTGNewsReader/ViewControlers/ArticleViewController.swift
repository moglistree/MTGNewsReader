//
//  ArticleViewController.swift
//  MTGNewsReader
//
//  Created by Martin on 11/1/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView : UIWebView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    var item : DefaultFeedItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebView()
        
        configureNavigationBar()
        
    }
    
    func configureNavigationBar(){
        
        let sel : Selector = Selector("share")
        let rightBarButton = UIBarButtonItem(title: "Share", style: .Plain, target: self, action: sel)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func share(){
    
        let activityView : UIActivityViewController = UIActivityViewController(activityItems: [item!.linkURL], applicationActivities:nil)
        var excluded = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact, UIActivityTypePrint]
        if #available(iOS 9.0, *) {
            excluded += [UIActivityTypeOpenInIBooks]
            activityView.excludedActivityTypes = excluded
        } else {
            activityView.excludedActivityTypes = excluded
        }
        
        self.presentViewController(activityView, animated: true, completion: nil)
        
    }
    
    func loadWebView(){
        let url : NSURL = NSURL(string: (item?.linkURL)!)!
        let req : NSURLRequest = NSURLRequest(URL : url)
        webView.loadRequest(req)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.hidden = false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidden = true
    }

}
