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
    
    var titleLabelMutual:UILabel = {
        let descLabel = UILabel(frame: CGRect(x:0, y: 0, width: (Int(cellWidth - 140)) , height: Int(imageWidth)))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.minimumScaleFactor = 2
        descLabel.adjustsFontSizeToFitWidth = true
        return descLabel
    }()
    
    var countLabelMutual:UILabel = {
        let descLabel = UILabel(frame: CGRect(x:Int(imageWidth + 30) , y: Int(imageWidth - 30), width: Int(UIScreen.main.bounds.width  - 40), height: 20))
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor(hex: 0xcccccc)
        descLabel.font = UIFont.systemFont(ofSize: 10)
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    var homeImageView:UIImageView = {
        let homeImageView = UIImageView(frame: CGRect(x: 15 , y: 5 , width: imageWidth - 10, height: imageWidth - 10))
        homeImageView.contentMode = UIViewContentMode.scaleAspectFill
        return homeImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let rect = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width , height: 40)
        let holderView:UIView = UIView(frame: rect)
        
        /*let widthConstraint = NSLayoutConstraint(item: self.titleLabelMutual , attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
        
        let heightConstraint = NSLayoutConstraint(item: self.titleLabelMutual, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)

        var constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[label]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: ["superview":holderView, "label":self.titleLabelMutual])
        
        
        
        
        holderView.addConstraints(constraints)*/
        
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







