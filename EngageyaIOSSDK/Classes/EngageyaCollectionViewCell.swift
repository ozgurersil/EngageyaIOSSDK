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
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        
        self.titleLabelMutual = UILabel(frame: CGRect(x:Int(OptionalParams.titlePaddingLeft), y: Int(OptionalParams.imageHeight) , width: Int(self.bounds.width) - Int(10) , height: 70))
        self.titleLabelMutual?.textAlignment = .left
        self.titleLabelMutual?.lineBreakMode = .byWordWrapping
        self.titleLabelMutual?.numberOfLines = 3
        self.titleLabelMutual?.adjustsFontSizeToFitWidth = true
        
        self.homeImageView = UIImageView(frame: CGRect(x: Double(OptionalParams.imagePaddingLeft) , y: OptionalParams.imagePaddingTop , width: Double(Int(self.bounds.width)), height: OptionalParams.imageHeight))
        self.homeImageView?.contentMode = UIViewContentMode.scaleToFill
        
        let padding = Int(OptionalParams.imagePaddingLeft) + Int(OptionalParams.imageWidth) + 10
        advertiserNameLabel = UILabel(frame: CGRect(x:Int(OptionalParams.brandPaddingLeft) , y: 0 , width: Int(OptionalParams.cellWidth) - Int(10), height: 20))
        
        self.advertiserNameLabel?.textAlignment = .left
        self.advertiserNameLabel?.textColor = UIColor(hex: 0xcccccc)
        
        if let fontFamily = OptionalParams.fontFamily {
            self.advertiserNameLabel?.font = UIFont(name: fontFamily.fontName, size: 10)
        }
        else{
            self.advertiserNameLabel?.font = UIFont.systemFont(ofSize: 10)
        }
        
        self.advertiserNameLabel?.lineBreakMode = .byWordWrapping
        self.advertiserNameLabel?.numberOfLines = 0
        
        self.addSubview(titleLabelMutual!)
        self.addSubview(homeImageView!)
        self.addSubview(advertiserNameLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
