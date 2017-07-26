//
//  EngageyaTypes.swift
//  Pods
//
//  Created by ozgur ersil on 26/07/2017.
//
//

public enum CreativeTypes : String {
    case tableView  = "tableView"
    case collectionView  = "collectionView"
}

public enum Align : String {
    case horizontal  = "x"
    case vertical  = "y"
}

public struct EngageyaBox {
    public var clickUrl:String!
    public var displayName:String!
    public var thumbnail_path:String!
    public var title:String!
    public var url:String!
}

public struct EngageyaWidget {
    public var boxes:[EngageyaBox]?
    public var widgetTitle:String?
}

