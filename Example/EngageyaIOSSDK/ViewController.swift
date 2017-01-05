//
//  ViewController.swift
//  EngageyaSDK
//
//  Created by ozgur on 01/04/2017.
//  Copyright (c) 2017 ozgur. All rights reserved.
//
import UIKit
import EngageyaIOSSDK


class ViewController: UIViewController {
    
    let engageya:EngageyaIOSSDK = EngageyaIOSSDK()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appId:[String:String] = [
            "pub_id" : "xxxxxx",
            "web_id" : "xxxxxx",
            "wid_id" : "xxxxxx",
            "url" : "http://xxx.com/xxx/938402-xxx-xx-xxxx"
        ]
        
        engageya.getWidgetData(idCollection: appId) { (widget:EngageyaWidget) in
                print("widgetTitle : \(widget.widgetTitle!)")
                print("recs: \(widget.boxes!)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
