//
//  ArticleViewController.swift
//  MTGNewsReader
//
//  Created by Martin on 11/1/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var webView : UIWebView!
    
    var item : CHFBItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url : NSURL = NSURL(string: (item?.linkURL)!)!
        let req : NSURLRequest = NSURLRequest(URL : url)
        webView.loadRequest(req)
    }

}
