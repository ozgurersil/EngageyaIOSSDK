//
//  ViewController.swift
//  EngageyaSDK
//
//  Created by ozgur on 01/04/2017.
//  Copyright (c) 2017 ozgur. All rights reserved.
//
import UIKit
import EngageyaIOSSDK
import SafariServices

class ViewController: UIViewController, UITableViewDelegate , UIWebViewDelegate {
    
    let engageya:EngageyaIOSSDK = EngageyaIOSSDK()
    
    var adWebview:UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let holder:UIView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(holder)
        
        let appId:[String:Any] = [
            "pub_id" : "164473",
            "web_id" : "127410",
            "wid_id" : "92644",
            "url" : "http://www.haberturk.com/spor/futbol/haber/938402-ultraslandan-tffye-cikarma",
            "imageWidth": 135,
            "imageHeight": 70,
            "fontSize": 12,
            "tilePadding": 5,
            "tileRowCount": 2,
            "tileHeight":140,
            "direction": "H"
        ]
        
        /*let appId:[String:Any] = [
         "pub_id" : "158041",
         "web_id" : "116302",
         "wid_id" : "90501",
         "url" : "http://www.ntv.com.tr/ekonomi/bookingin-turkiye-faaliyetleri-durduruldu,2FQkwmZf5kecnYXAsRQ9Hw",
         "imageWidth": 135,
         "imageHeight": 70,
         "fontSize": 12,
         "tileRowCount": 4,
         "tilePadding": 0
         ]*/
        
        
        
     /*   self.engageya.createListView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.eventManager.listenTo(eventName: "tapped", action: self.clickAction)
        }*/
        
        self.engageya.createCollectionView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.eventManager.listenTo(eventName: "tapped", action: self.clickAction)
        }
      
    }
    
    func clickAction(information:Any?){
        if let box = information as? EngageyaBox {
            if let displayName = box.displayName {
                print("this is an ad \(displayName)")
                let url = "https:\(box.clickUrl!)"
                if #available(iOS 9.0, *) {
                    let svc = SFSafariViewController(url: NSURL(string: url)! as URL)
                    self.present(svc, animated: true, completion: nil)
                } else {
                    adWebview = UIViewController()
                    let webView:UIWebView = UIWebView(frame: UIScreen.main.bounds)
                    webView.delegate = self
                    webView.loadRequest(URLRequest(url: URL(string: url)!))
                    let newBackButton = UIButton(frame: CGRect(x: 5, y: 5, width: 30 , height: 30))
                    newBackButton.backgroundColor = UIColor.black
                    newBackButton.setTitle("X", for: .normal)
                    newBackButton.layer.cornerRadius = 2
                    newBackButton.addTarget(self, action: #selector(self.backPressed(sender:)), for: .touchDown)
                    adWebview?.view.addSubview(webView)
                    adWebview?.view.addSubview(newBackButton)
                    self.present(adWebview!, animated: true, completion: {
                        print("moved")
                    })
                }
             }
            else{
                print("this is not an ad \(box.clickUrl)")
            }
        }
    }
    
    func backPressed(sender: Any) {
        self.adWebview?.dismiss(animated: true, completion: {
            print("dismissed")
        })
    }
    
    
       
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
