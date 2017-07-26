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
    
    var engageya:EngageyaIOSSDK!
    var adWebview:UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let holder:UIView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(holder)
        
        
        let url = "http://www.ntv.com.tr/galeri/teknoloji/cocuklar-icin-sadece-gunduz-calisan-akilli-telefon-uretildi,kuoCYkk5pUeHsmlL4TddFw"
        
        let appSettings:[String:Any] = [
            "titlePaddingLeft":5,
            "titlePaddingTop":5,
            "imagePaddingLeft":2,
            "imageWidth": 75,
            "imageHeight": 50,
            "tileHeight":100,
            "fontFamily":UIFont.systemFont(ofSize: 13),
            "fontSize": 12,
            "widgetHeight" : 210,
            "tileRowCount" : 2
        ]
        
        self.engageya = EngageyaIOSSDK(pubid:"158041",webid:"116302",widid:"89852")
      
        
        /*self.engageya.sharedCreatives().createCollectionView(url: url,options: appSettings) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.getEventManager().listenTo(eventName: "tapped", action: self.clickAction)
        }*/
        
        self.engageya.sharedCreatives().createCollectionView(url: url,options: appSettings) { (widget:UIView) in
            holder.addSubview(widget)
            self.engageya.getEventManager().listenTo(eventName: "tapped", action: self.clickAction)
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
                print("this is not an ad \(box.url!)")
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
