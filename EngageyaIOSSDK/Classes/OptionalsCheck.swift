//
//  OptionalsCheck.swift
//  Pods
//
//  Created by ozgur ersil on 26/07/2017.
//
//

import UIKit

class OptionalsCheck: NSObject {
    public static func checkOptionals(idCollection:[String:Any],type:CreativeTypes){
        /// optionals
        if let imageWidth = idCollection["imageWidth"] as? Int{
            OptionalParams.imageWidth = Double(imageWidth)
        }
        if let imageHeight = idCollection["imageHeight"] as? Int {
            OptionalParams.imageHeight = Double(imageHeight)
        }
        
        if let imagePaddingLeft = idCollection["imagePaddingLeft"] as? Int{
            OptionalParams.imagePaddingLeft = Double(imagePaddingLeft)
        }
        
        if let imagePaddingTop = idCollection["imagePaddingTop"] as? Int{
            OptionalParams.imagePaddingTop = Double(imagePaddingTop)
        }
        
        if let titlePaddingLeft = idCollection["titlePaddingLeft"] as? Int{
            OptionalParams.titlePaddingLeft = Double(titlePaddingLeft)
        }
        
        if let titlePaddingTop = idCollection["titlePaddingTop"] as? Int{
            OptionalParams.titlePaddingTop = Double(titlePaddingTop)
        }
        
        if let tilePadding = idCollection["tilePadding"] as? Int{
            OptionalParams.tilePadding = Double(tilePadding)
        }
        
        if let tileRowCount = idCollection["tileRowCount"] as? Int{
            if type == .collectionView {
                OptionalParams.tileRowCount = tileRowCount
            }
        }
        
        if let fontSize = idCollection["fontSize"] as? Int {
            OptionalParams.fontSize = fontSize
        }
        
        if let fontFamily = idCollection["fontFamily"] as? UIFont {
            OptionalParams.fontFamily = fontFamily
        }
        
        if let widgetHeight = idCollection["widgetHeight"] as? Int{
            OptionalParams.widgetHeight = Int(widgetHeight)
            print("widget height defined")
        }
        
        if let tileHeight = idCollection["tileHeight"] as? Int{
            OptionalParams.tileHeight = Double(tileHeight)
        }
        
        if let maxLines = idCollection["maxLines"] as? Int{
            OptionalParams.maxLines = maxLines
        }
        
        if let direction = idCollection["direction"] as? String{
            if type == .tableView {
                // EngageyaTableViewCell.tilePadding = tilePadding
            }
            else{
                if direction == "V" {
                    OptionalParams.direction = .vertical
                }
                else{
                    OptionalParams.direction = .horizontal
                }
            }
        }
        
        if let fontColor = idCollection["fontColor"] as? UIColor{
            OptionalParams.fontColor = fontColor
        }
    }
}
