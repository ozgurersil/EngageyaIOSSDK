//
//  ViewController.swift
//  EngageyaSDK
//
//  Created by ozgur on 01/04/2017.
//  Copyright (c) 2017 ozgur. All rights reserved.
//
import UIKit
import EngageyaIOSSDK


class ViewController: UIViewController, UITableViewDelegate {
    
    let engageya:EngageyaIOSSDK = EngageyaIOSSDK()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let holder:UIView = UIView(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(holder)
        
      
        
 
        
        /*let appId:[String:String] = [
            "pub_id" : "xxx",
            "web_id" : "xxx",
            "wid_id" : "xxx",
            "url" : "xxx"
        ]*/
        
 
        
        
        self.engageya.createListView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
            print(self.engageya)
            //let f:EventManager = self.engageya.getEventManager()
            
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
