//
//  CreativesView.swift
//  Pods
//
//  Created by ozgur ersil on 25/07/2017.
//
//

import UIKit
import Foundation


func getDataFromUrl(_ url:String, completion: @escaping ((_ data: Data?) -> Void)) {
    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
        if let newData = data {
            completion(NSData(data: newData) as Data)
        }
        else{
            print("creative did not loaded")
        }
        
    }) .resume()
}

public class EngageyaCreativesView: NSObject, UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource {
    
    public var tableView:UITableView?
    public var cView:UICollectionView?
    public var items = [EngageyaBox]()
    public var imageCache = Dictionary<String, UIImage>()
    public var eventManager:EventManager = EventManager()
    
    var titleLabel:UILabel = {
        let descLabel = UILabel(frame: CGRect(x:Int(5), y: 0, width: Int(UIScreen.main.bounds.width) , height: 40))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        descLabel.numberOfLines = 1
        descLabel.textColor = UIColor(hex: 0x202020)
        return descLabel
    }()
    
    public override init(){
        super.init()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func getEventManager()->EventManager{
        return self.eventManager
    }
    
    
    // get widget data
    public func getWidgetData(url:String, compliation:@escaping (_ widget:EngageyaWidget)->()){
        let url = JSONRequestHandler.createURL(url: url)
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            compliation(widget)
        }
    }

    // get collectionView
    public func createCollectionView(url:String ,options:[String:Any]?,compliation:@escaping (_ widget:UIView)->()){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        let url = JSONRequestHandler.createURL(url: url)
        
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            // set optionals if exist
            if let definedOptions  = options {
                OptionalsCheck.checkOptionals(idCollection: definedOptions, type: .collectionView)
            }
            
            // set data array
            self.items = widget.boxes!
            
            let holderView:UIView = UIView(frame: UIScreen.main.bounds)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0 , right: 5)
            
            var calculateHeight = 0
            
            if (OptionalParams.direction == .horizontal){
                layout.itemSize = CGSize(width: (200) , height: CGFloat(OptionalParams.tileHeight))
                layout.scrollDirection = .horizontal
                calculateHeight = Int(OptionalParams.tileHeight)
            }
            else{
                
                layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/CGFloat(OptionalParams.tileRowCount) - CGFloat(OptionalParams.tilePadding)) , height: CGFloat(OptionalParams.tileHeight))
                
                if let heightDefined = OptionalParams.widgetHeight {
                    calculateHeight = heightDefined
                }
                else{
                    calculateHeight = Int(Double(self.items.count / OptionalParams.tileRowCount) * Double(OptionalParams.tileHeight) + Double(self.items.count / OptionalParams.tileRowCount))
                }
                
            }
            
            let rect = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: CGFloat(calculateHeight+10))
            self.cView = UICollectionView(frame: rect, collectionViewLayout: layout)
            self.cView?.register(EngageyaCollectionViewCell.self, forCellWithReuseIdentifier: "goCell")
            self.cView?.dataSource = self
            self.cView?.delegate = self
            self.cView?.backgroundColor = UIColor.white
            
            holderView.addSubview(self.titleLabel)
            holderView.addSubview(self.cView!)
            
            DispatchQueue.main.async {
                self.titleLabel.text = widget.widgetTitle!
                compliation(holderView)
            }
        }
    }
    
    // get tableView
    public func createListView(url:String, options:[String:Any]?,compliation:@escaping (_ widget:UIView)->()){
        let url = JSONRequestHandler.createURL(url: url)
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            
            // set optionals if exist
            if let definedOptions  = options {
                OptionalsCheck.checkOptionals(idCollection: definedOptions, type: .tableView)
            }
            // set data array
            self.items = widget.boxes!
            
            // create tableView and its holder
            let holderView:UIView = UIView(frame: UIScreen.main.bounds)
            var rect = CGRect(x: 0.0, y: 40.0, width: Double(OptionalParams.cellWidth), height: Double(self.items.count) * OptionalParams.tileHeight)
            
            if let widgetHeight = OptionalParams.widgetHeight {
                rect = CGRect(x: 0.0, y: 40.0, width: Double(OptionalParams.cellWidth), height: Double(widgetHeight))
            }
            self.tableView = UITableView(frame: rect, style: .plain)
            self.tableView?.register(EngageyaTableViewCell.self, forCellReuseIdentifier: "box")
            self.tableView?.separatorStyle = .none
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.alwaysBounceVertical = false
            
            holderView.addSubview(self.titleLabel)
            holderView.addSubview(self.tableView!)
            
            DispatchQueue.main.async {
                self.titleLabel.text = widget.widgetTitle
                compliation(holderView)
            }
        }
    }
    
    // Detect orientation changes
    
    func rotated() {
        guard let flowLayout = cView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        /*if UIDevice.current.orientation.isLandscape {
         print("Landscape")
         var count = UIScreen.main.bounds.width / CGFloat(EngageyaCollectionViewCell.imageWidth)
         flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / count) - 12, height: 140)
         self.cView?.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 300)
         self.cView?.setNeedsLayout()
         
         } else {
         print("Portrait")
         flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 12, height: 140)
         self.cView?.frame = CGRect(x:0,y:40,width:UIScreen.main.bounds.width,height:400)
         self.cView?.setNeedsLayout()
         }
         flowLayout.invalidateLayout()*/
    }
    
    
    // CollectionView Overrides
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tile:EngageyaBox = self.items[indexPath.row] as EngageyaBox{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goCell", for: indexPath) as! EngageyaCollectionViewCell
                cell.tag = (indexPath as NSIndexPath).row
            if let title = tile.title{
                cell.titleLabelMutual?.text = String(htmlEncodedString:tile.title)
            }
            cell.titleLabelMutual?.sizeToFit()
            cell.titleLabelMutual?.frame.origin.y = CGFloat(OptionalParams.imageHeight) + CGFloat(OptionalParams.titlePaddingTop)
            
            cell.advertiserNameLabel?.frame.origin.y = (cell.titleLabelMutual?.frame.height)! + CGFloat(OptionalParams.imageHeight) + 3
            if let displayName = tile.displayName {
                cell.advertiserNameLabel?.text = String(htmlEncodedString:displayName)
            }
            else{
                cell.advertiserNameLabel?.text = ""
            }

                if let imageURL = (tile.thumbnail_path) {
                    getDataFromUrl("https:"+imageURL) { data in
                        DispatchQueue.main.async {
                            if(cell.tag == (indexPath as NSIndexPath).row){
                                let image = UIImage(data: data!)
                                cell.homeImageView?.image = image
                            }
                        }
                    }
                }
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.eventManager.trigger(eventName: "tapped", information: items[indexPath.row])
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    //TableView Overrides
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(OptionalParams.tileHeight)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventManager.trigger(eventName: "tapped", information: items[indexPath.row])
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let box = self.items[indexPath.row] as? EngageyaBox {
            let cell = self.tableView?.dequeueReusableCell(withIdentifier: "box", for: indexPath) as! EngageyaTableViewCell
            cell.tag = (indexPath as NSIndexPath).row
            let thumbnailURL =  "https:\(box.thumbnail_path!)"
            getDataFromUrl(thumbnailURL) { data in
                DispatchQueue.main.async {
                    if(cell.tag == (indexPath as NSIndexPath).row) {
                        let image = UIImage(data: data!)
                        self.imageCache[String(box.thumbnail_path)] = image
                        cell.homeImageView.image = image
                        cell.titleLabelMutual.text = String(htmlEncodedString: box.title)
                        if let displayName = box.displayName {
                            cell.advertiserNameLabel.text = String(htmlEncodedString:displayName)
                        }
                        cell.titleLabelMutual.sizeToFit()
                        cell.advertiserNameLabel.frame.origin.x = cell.titleLabelMutual.frame.origin.x
                        cell.advertiserNameLabel.frame.origin.y = cell.titleLabelMutual.frame.height + cell.titleLabelMutual.frame.origin.y
                    }
                }
            }
            return cell
        }
    }

}
