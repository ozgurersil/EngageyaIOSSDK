//
//  EngageyaTableViewCell.swift
//  EngageyaIOSSDK
//
//  Created by Engageya on 10/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class EngageyaTableViewCell: UITableViewCell {
    
    //// title
    var titleLabelMutual:UILabel = {
        let padding = Int(OptionalParams.imagePaddingLeft) + Int(OptionalParams.imageWidth) + Int(OptionalParams.titlePaddingLeft)
        let descLabel = UILabel(frame: CGRect(x:Int(padding), y: Int(OptionalParams.titlePaddingTop) , width: Int(OptionalParams.cellWidth) - Int(padding) , height: 50))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byTruncatingTail
        descLabel.numberOfLines = OptionalParams.maxLines
        descLabel.textColor = OptionalParams.fontColor;
        return descLabel
    }()
    
    //// brandName
    var advertiserNameLabel:UILabel = {
        let padding = Int(OptionalParams.imagePaddingLeft) + Int(OptionalParams.imageWidth)
        let descLabel = UILabel(frame: CGRect(x:padding , y:0 , width: Int(OptionalParams.cellWidth) - Int(padding), height: 12))
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor(hex: 0xcccccc)
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    //// thumbNail image
    var homeImageView:UIImageView = {
        let homeImageView = UIImageView(frame: CGRect(x: Double(OptionalParams.imagePaddingLeft) , y: OptionalParams.imagePaddingTop , width: OptionalParams.imageWidth, height: OptionalParams.imageHeight))
        homeImageView.contentMode = UIViewContentMode.scaleAspectFill
        homeImageView.clipsToBounds = true
        return homeImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let rect = CGRect(x: 0.0, y: 0.0, width: Double(UIScreen.main.bounds.width) , height: OptionalParams.imageHeight)
        let holderView:UIView = UIView(frame: rect)
        
        //// check fontSize and fontFamily
        if let fontFamily = OptionalParams.fontFamily {
            if let fontSize = OptionalParams.fontSize {
                self.titleLabelMutual.font = UIFont(name: fontFamily.fontName, size: CGFloat(fontSize))
            }
            else{
                self.titleLabelMutual.font = UIFont(name: fontFamily.fontName, size: 18)
            }
            self.advertiserNameLabel.font = UIFont(name: fontFamily.fontName, size: CGFloat(10))
            
        }
        else{
            self.titleLabelMutual.font = UIFont.systemFont(ofSize: 12)
        }
        
        //// adding to scene
        holderView.addSubview(self.titleLabelMutual)
        holderView.addSubview(self.homeImageView)
        holderView.addSubview(self.advertiserNameLabel)
        self.addSubview(holderView)
    }
    
    override func prepareForReuse() {
        self.titleLabelMutual.text = nil
        self.advertiserNameLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded() //This is the solution for :changed only after I tap the each cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}







