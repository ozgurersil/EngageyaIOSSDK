//
//  ViewController.swift
//  EngageyaSDK
//
//  Created by ozgur on 01/04/2017.
//  Copyright (c) 2017 ozgur. All rights reserved.
//
import UIKit
import EngageyaIOSSDK


class ViewController: UIViewController, UITableViewDelegate , UIWebViewDelegate {
    
    let engageya:EngageyaIOSSDK = EngageyaIOSSDK()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let holder:UIView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(holder)
        
        
        let appId:[String:Any] = [
            "pub_id" : "xxx",
            "web_id" : "xxx",
            "wid_id" : "xxx",
            "url" : "http://www.xxx.com/spor/futbol/haber/938402-ultraslandan-tffye-cikarma",
            "imageWidth": 70,
            "imageHeight": 70,
            "fontSize": 12,
            "tilePadding": 5
        ]
        
        self.engageya.createListView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.eventManager.listenTo(eventName: "tapped", action: self.clickAction)
        }
      
    }
    
    func clickAction(information:Any?){
        if let box = information as? EngageyaBox {
            if let displayName = box.displayName {
                print("this is an ad \(displayName)")
                let webView = UIWebView(frame: UIScreen.main.bounds)
                if #available(iOS 9.0, *) {
                    webView.allowsLinkPreview = true
                } else {
                    // Fallback on earlier versions
                }
                webView.delegate = self
                view.addSubview(webView)
                let url = "https:\(box.clickUrl!)"
                let encoded_url = URL(string: url)!
                webView.loadRequest(URLRequest(url: encoded_url))
    
            }
            else{
                print("this is not an ad \(box.clickUrl)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
