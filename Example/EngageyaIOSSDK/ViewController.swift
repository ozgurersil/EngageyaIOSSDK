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
    
    let en:EngageyaIOSSDK = EngageyaIOSSDK()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let idS:[String:String] = [
            "pub_id" : "164473",
            "web_id" : "127410",
            "wid_id" : "92644",
            "url" : "http://www.haberturk.com/spor/futbol/haber/938402-ultraslandan-tffye-cikarma"
        ]
        
        
        en.createWidget(idCollection: idS, creativeType: .tableView, align: .vertical) { (view) in
            DispatchQueue.main.async {
                if let tableView:UITableView = view as? UITableView{
                    self.view.addSubview(tableView)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
