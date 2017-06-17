//
//  EngageyaTableViewCell.swift
//  EngageyaIOSSDK
//
//  Created by Engageya on 10/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class EngageyaTableViewCell: UITableViewCell {
    
    var titleLabelMutual:UILabel = {
        let padding = Int(OptionalParams.imagePaddingLeft) + Int(OptionalParams.imageWidth) + Int(OptionalParams.titlePaddingLeft)
        let descLabel = UILabel(frame: CGRect(x:Int(padding), y: Int(OptionalParams.imagePaddingTop) , width: Int(OptionalParams.cellWidth) - Int(padding) , height: 70))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 3
        //descLabel.adjustsFontSizeToFitWidth = true
        return descLabel
    }()
    
    var advertiserNameLabel:UILabel = {
        let padding = Int(OptionalParams.imagePaddingLeft) + Int(OptionalParams.imageWidth) + 10
        let descLabel = UILabel(frame: CGRect(x:padding , y: 0 , width: Int(OptionalParams.cellWidth) - Int(padding), height: 12))
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor(hex: 0xcccccc)
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    
    var homeImageView:UIImageView = {
        let homeImageView = UIImageView(frame: CGRect(x: Double(OptionalParams.imagePaddingLeft) , y: OptionalParams.imagePaddingTop , width: OptionalParams.imageWidth, height: OptionalParams.imageHeight))
        homeImageView.contentMode = UIViewContentMode.scaleToFill
        return homeImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let rect = CGRect(x: 0.0, y: 0.0, width: Double(UIScreen.main.bounds.width) , height: OptionalParams.imageHeight)
        let holderView:UIView = UIView(frame: rect)
        
        holderView.addSubview(self.titleLabelMutual)
        holderView.addSubview(self.homeImageView)
        holderView.addSubview(self.advertiserNameLabel)
        
        self.addSubview(holderView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    

}







