//
//  EngageyaSDK.swift
//  Pods
//
//  Created by Engageya on 04/01/2017.
//
//
import UIKit


 public class EngageyaIOSSDK : NSObject {
    
    // Variables
    public static var pubid:String?
    public static var webid:String?
    public static var widid:String?
    public var creatives:EngageyaCreativesView!
    
    public init(pubid:String,webid:String,widid:String){
        super.init()
        EngageyaIOSSDK.pubid = pubid
        EngageyaIOSSDK.webid = webid
        EngageyaIOSSDK.widid = widid
    }
    
    public func sharedCreatives() -> EngageyaCreativesView {
        self.creatives = EngageyaCreativesView()
        return self.creatives
    }
    
    public func getEventManager() -> EventManager {
        return self.creatives.getEventManager()
    }
    
}
