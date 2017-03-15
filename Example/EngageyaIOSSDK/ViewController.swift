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
        
       let appId:[String:String] = [
            "pub_id" : "162254",
            "web_id" : "123480",
            "wid_id" : "92608",
            "url" : "http://www.haber7.com/siyaset/haber/2257926-bahceliden-turkese-nankorluk-sayarim"
        ]
        
 
        
        /*let appId:[String:String] = [
            "pub_id" : "164473",
            "web_id" : "127410",
            "wid_id" : "92644",
            "url" : "http://www.haberturk.com/spor/futbol/haber/938402-ultraslandan-tffye-cikarma"
        ]*/
        
 
        
        
        self.engageya.createListView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.tableView.delegate = self
            
            //let f:EventManager = self.engageya.getEventManager()
            
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
