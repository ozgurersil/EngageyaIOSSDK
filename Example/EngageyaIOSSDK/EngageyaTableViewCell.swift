//
//  EngageyaTableViewCell.swift
//  EngageyaIOSSDK
//
//  Created by Engageya on 10/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class EngageyaTableViewCell: UITableViewCell {

    
    static var cellWidth = UIScreen.main.bounds.width
    
    static var imageWidth = 80.0
    
    static var imageHeight = 80.0
    
    static var imagePaddingLeft = 5
    
    static var imagePaddingTop = 5.0
    
    static var tilePadding = 5
    
    static var fontSize:Int?
    
    var titleLabelMutual:UILabel = {
        let padding = Int(imagePaddingLeft) + Int(imageWidth) + 10
        let descLabel = UILabel(frame: CGRect(x:Int(imageWidth + 10), y: Int(imagePaddingTop) , width: Int(cellWidth) - Int(padding) , height: 70))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 3
        
        descLabel.adjustsFontSizeToFitWidth = true
        return descLabel
    }()
    
    var countLabelMutual:UILabel = {
        let padding = Int(imagePaddingLeft) + Int(imageWidth) + 10
        let descLabel = UILabel(frame: CGRect(x:Int(imageWidth + 10) , y: 0 , width: Int(cellWidth) - Int(padding), height: 10))
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor(hex: 0xcccccc)
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    var homeImageView:UIImageView = {
        let homeImageView = UIImageView(frame: CGRect(x: Double(imagePaddingLeft) , y: imagePaddingTop , width: imageWidth, height: imageHeight))
        homeImageView.contentMode = UIViewContentMode.scaleToFill
        return homeImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let rect = CGRect(x: 0.0, y: 0.0, width: Double(UIScreen.main.bounds.width) , height: EngageyaTableViewCell.imageHeight+10)
        let holderView:UIView = UIView(frame: rect)
        
        holderView.addSubview(self.titleLabelMutual)
        holderView.addSubview(self.homeImageView)
        holderView.addSubview(self.countLabelMutual)
        
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







