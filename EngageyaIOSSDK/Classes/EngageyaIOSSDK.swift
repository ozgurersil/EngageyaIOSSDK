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

public struct EngageyaBox {
    var clickUrl:String!
    var displayName:String!
    var thumbnail_path:String!
    var title:String!
}

public struct EngageyaWidget {
    public var boxes:[EngageyaBox]?
    public var widgetTitle:String?
}


public class EngageyaIOSSDK : NSObject {
    
    public func getWidgetData(idCollection:[String:String], compliation:@escaping (_ widget:EngageyaWidget)->()){
        let url = JSONRequestHandler.createURL(collections: idCollection)
        
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url")
                return
            }
            compliation(widget)
        }
    }
    
    
    
}
