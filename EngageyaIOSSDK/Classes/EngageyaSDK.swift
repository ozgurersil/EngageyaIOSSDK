//
//  EngageyaSDK.swift
//  Pods
//
//  Created by Engageya on 04/01/2017.
//
//
import Foundation
import UIKit


public enum CreativeTypes : String {
    case tableView  = "tableView"
    case collectionView  = "collectionView"
    
}

public enum Align : String {
    case horizontal  = "x"
    case vertical  = "y"
}

struct Box {
    var clickUrl:String?
    var displayName:String?
    var thumbnail_path:String?
    var title:String?
}


public class EngageyaSDK : NSObject {
    
    public func createWidget(idCollection:[String:String], creativeType:CreativeTypes , align:Align, compliation:@escaping (_ view:AnyObject )->()) {
        let url = JSONRequestHandler.createURL(collections: idCollection)
        
        JSONRequestHandler.makeHTTPRequest(url: url) { (status, data) in
            if !status {
                print("error with loading URL")
                return
            }
            else{
                switch creativeType {
                case .tableView:
                    let g:UITableView = UITableView(frame: UIScreen.main.bounds , style: .plain)
                    let t:EngageyaTableViewController = EngageyaTableViewController(style: .plain)
                    g.dataSource = t
                    g.delegate = t
                    compliation(g)
                    break
                    
                case .collectionView:
                    
                    break
                }
                /* for(index,value) in data.enumerated(){
                 guard let thumbnail_path:String = (value as AnyObject)["thumbnail_path"] as? String else{
                 return
                 }
                 guard let title:String = (value as AnyObject)["title"] as? String else{
                 return
                 }
                 
                 guard let clickUrl:String = (value as AnyObject)["clickUrl"] as? String else{
                 return
                 }
                 
                 
                 // displayName can be optional (brand title)
                 var displayNameFinal = ""
                 if let displayName:String = (value as AnyObject)["displayName"] as? String {
                 displayNameFinal = displayName
                 }
                 
                 let box:Box = Box(clickUrl: clickUrl, displayName: displayNameFinal, thumbnail_path: thumbnail_path, title: title)
                 print(box.thumbnail_path!)
                 }*/
            }
        }
    }
    
    
}
