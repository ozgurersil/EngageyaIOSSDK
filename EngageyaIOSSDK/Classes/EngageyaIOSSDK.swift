//
//  EngageyaSDK.swift
//  Pods
//
//  Created by Engageya on 04/01/2017.
//
//
import Foundation
import UIKit


extension String {
    init(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
}


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
}

public struct EngageyaWidget {
    public var boxes:[EngageyaBox]?
    public var widgetTitle:String?
}


func getDataFromUrl(_ url:String, completion: @escaping ((_ data: Data?) -> Void)) {
    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
        completion(NSData(data: data!) as Data)
    }) .resume()
}



public class EngageyaIOSSDK : NSObject , UITableViewDelegate , UITableViewDataSource {
    
    // Variables
    
    public var tableView:UITableView?
    public var items = [EngageyaBox]()
    public var imageCache = Dictionary<String, UIImage>()
    public var eventManager:EventManager = EventManager()
    
    public override init(){
        
    }

    var titleLabel:UILabel = {
        let descLabel = UILabel(frame: CGRect(x:Int(5), y: 0, width: Int(UIScreen.main.bounds.width) , height: 40))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        descLabel.numberOfLines = 1
        descLabel.textColor = UIColor(hex: 0x202020)
        return descLabel
    }()
    
    func getEventManager()->EventManager{
        return self.eventManager
    }
    
    // Methods
    
    public func getWidgetData(idCollection:[String:String], compliation:@escaping (_ widget:EngageyaWidget)->()){
        let url = JSONRequestHandler.createURL(collections: idCollection)
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            compliation(widget)
        }
    }
    
    public func createListView(idCollection:[String:Any] ,compliation:@escaping (_ widget:UIView)->()){
        let url = JSONRequestHandler.createURL(collections: (idCollection as? [String : Any])!)
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            
            // set optionals if exist
            self.checkOptionals(idCollection: idCollection)
            
            
            // set data array
            self.items = widget.boxes!
            
            
            // create tableView and its holder
            let holderView:UIView = UIView(frame: UIScreen.main.bounds)
            let rect = CGRect(x: 0.0, y: 40.0, width: Double(UIScreen.main.bounds.width), height: Double(self.items.count) * EngageyaTableViewCell.imageHeight + Double(self.items.count) * Double(EngageyaTableViewCell.tilePadding))
            self.tableView = UITableView(frame: rect, style: .plain)
            self.tableView?.register(EngageyaTableViewCell.self, forCellReuseIdentifier: "box")
            self.tableView?.separatorStyle = .none
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            
            holderView.addSubview(self.titleLabel)
            holderView.addSubview(self.tableView!)

            DispatchQueue.main.async {
                self.titleLabel.text = widget.widgetTitle
                compliation(holderView)
            }
        }
    }
    
    public func checkOptionals(idCollection:[String:Any]){
        /// optionals
        if let imageWidth = idCollection["imageWidth"] as? Int{
            EngageyaTableViewCell.imageWidth = Double(imageWidth)
        }
        if let imageHeight = idCollection["imageHeight"] as? Int {
            EngageyaTableViewCell.imageHeight = Double(imageHeight)
        }
        
        if let fontSize = idCollection["fontSize"] as? Int {
            EngageyaTableViewCell.fontSize = fontSize
        }
        
        if let tilePadding = idCollection["tilePadding"] as? Int {
            EngageyaTableViewCell.tilePadding = tilePadding
        }
    }
    
    
    //TableView Overrides
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(EngageyaTableViewCell.imageHeight) + CGFloat(EngageyaTableViewCell.tilePadding)
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
                           cell.countLabelMutual.text = String(htmlEncodedString:displayName)
                            
                        }
                        if let fontSize = EngageyaTableViewCell.fontSize {
                            cell.titleLabelMutual.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
                        }
                        
                        cell.titleLabelMutual.sizeToFit()
                        cell.countLabelMutual.frame.origin.y = cell.titleLabelMutual.frame.height + 10
                    }
                }
            }
            return cell
        }
    }

    
    
}
