//
//  EngageyaCollectionViewCell.swift
//  Pods
//
//  Created by Ozgur on 29/03/17.
//
//

import UIKit

class EngageyaCollectionViewCell: UICollectionViewCell {
    
    var titleLabelMutual:UILabel?
    var homeImageView:UIImageView?
    var advertiserNameLabel:UILabel?
    let titlePaddingRight = 5
    
    override init(frame:CGRect){
        super.init(frame:frame)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: 0xf7f7f7).cgColor
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        
        //// title
        self.titleLabelMutual = UILabel(frame: CGRect(x:Int(OptionalParams.titlePaddingLeft), y: Int(OptionalParams.titlePaddingTop) , width: Int(self.bounds.width) - titlePaddingRight , height: 0))
        self.titleLabelMutual?.textAlignment = .left
        self.titleLabelMutual?.lineBreakMode = .byTruncatingTail
        self.titleLabelMutual?.numberOfLines = OptionalParams.maxLines
        
        //// thumbnail image
        self.homeImageView = UIImageView(frame: CGRect(x: Double(OptionalParams.imagePaddingLeft) , y: OptionalParams.imagePaddingTop , width: Double(Int(self.bounds.width)), height: OptionalParams.imageHeight))
        self.homeImageView?.contentMode = UIViewContentMode.scaleAspectFill
        self.homeImageView?.clipsToBounds = true
        
        //// brandName
        advertiserNameLabel = UILabel(frame: CGRect(x:Int(OptionalParams.titlePaddingLeft) , y: 0 , width: Int(OptionalParams.cellWidth) - Int(10), height: 20))
        self.advertiserNameLabel?.textAlignment = .left
        self.advertiserNameLabel?.textColor = UIColor(hex: 0xcccccc)
        self.advertiserNameLabel?.lineBreakMode = .byWordWrapping
        self.advertiserNameLabel?.numberOfLines = 0
        
        //// check fontSize and fontFamily
        if let fontFamily = OptionalParams.fontFamily {
            if let fontSize = OptionalParams.fontSize {
                self.titleLabelMutual?.font = UIFont(name: fontFamily.fontName, size: CGFloat(fontSize))
            }
            else{
                self.titleLabelMutual?.font = UIFont(name: fontFamily.fontName, size: 12)
            }
            self.advertiserNameLabel?.font = UIFont(name: fontFamily.fontName, size: CGFloat(10))
        }
        else{
            self.titleLabelMutual?.font = UIFont.systemFont(ofSize: 12)
        }
        
        //// adding to scene
        self.addSubview(homeImageView!)
        self.addSubview(titleLabelMutual!)
        self.addSubview(advertiserNameLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
