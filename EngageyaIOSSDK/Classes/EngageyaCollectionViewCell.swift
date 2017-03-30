//
//  EngageyaCollectionViewCell.swift
//  Pods
//
//  Created by Ozgur on 29/03/17.
//
//

import UIKit

class EngageyaCollectionViewCell: UICollectionViewCell {
    
    static var cellWidth = UIScreen.main.bounds.width
    
    static var imageWidth = 80.0
    
    static var imageHeight = 80.0
    
    static var imagePaddingLeft = 5
    
    static var imagePaddingTop = 5.0
    
    static var tilePadding = 10
    
    static var tileRowCount = 2
    
    static var fontSize:Int?
    
    static var tileHeight = 100
    
    static var direction:Align = .vertical
    
    var titleLabelMutual:UILabel?
    var homeImageView:UIImageView?
    var countLabelMutual:UILabel?
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        
        self.titleLabelMutual = UILabel(frame: CGRect(x:EngageyaCollectionViewCell.imagePaddingLeft, y: Int(EngageyaCollectionViewCell.imageHeight) , width: Int(self.bounds.width) - Int(10) , height: 70))
        self.titleLabelMutual?.textAlignment = .left
        self.titleLabelMutual?.lineBreakMode = .byWordWrapping
        self.titleLabelMutual?.numberOfLines = 3
        self.titleLabelMutual?.adjustsFontSizeToFitWidth = true
        
        self.homeImageView = UIImageView(frame: CGRect(x: Double(EngageyaCollectionViewCell.imagePaddingLeft) , y: EngageyaCollectionViewCell.imagePaddingTop , width: Double(Int(self.bounds.width) - Int(10)), height: EngageyaCollectionViewCell.imageHeight))
        self.homeImageView?.contentMode = UIViewContentMode.scaleToFill
        
        let padding = Int(EngageyaCollectionViewCell.imagePaddingLeft) + Int(EngageyaCollectionViewCell.imageWidth) + 10
        countLabelMutual = UILabel(frame: CGRect(x:EngageyaCollectionViewCell.imagePaddingLeft , y: 0 , width: Int(self.bounds.width) - Int(10), height: 20))
        self.countLabelMutual?.textAlignment = .left
        self.countLabelMutual?.textColor = UIColor(hex: 0xcccccc)
        self.countLabelMutual?.font = UIFont.systemFont(ofSize: 10)
        self.countLabelMutual?.lineBreakMode = .byWordWrapping
        self.countLabelMutual?.numberOfLines = 0
        
        self.addSubview(titleLabelMutual!)
        self.addSubview(homeImageView!)
        self.addSubview(countLabelMutual!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
