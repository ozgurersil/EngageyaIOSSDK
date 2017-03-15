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

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: -1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (NSString(string: hex).length) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
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
    var clickUrl:String!
    var displayName:String!
    var thumbnail_path:String!
    var title:String!
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
    
    var tableView:UITableView?
    var items = [EngageyaBox]()
    var imageCache = Dictionary<String, UIImage>()
    var eventManager:EventManager = EventManager()
    
    var titleLabel:UILabel = {
        let descLabel = UILabel(frame: CGRect(x:Int(5), y: 0, width: Int(UIScreen.main.bounds.width) , height: 40))
        descLabel.textAlignment = .left
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.font = UIFont.systemFont(ofSize: 18)
        descLabel.numberOfLines = 1
        descLabel.textColor = UIColor(hex: 0x202020)
        return descLabel
    }()
    
    
    public override init(){
        
    }
    
    
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
    
    public func createListView(idCollection:[String:String], compliation:@escaping (_ widget:UIView)->()){
        let url = JSONRequestHandler.createURL(collections: idCollection)
        JSONRequestHandler.getWidgetJSONResponse(url: url) { (bool, widget) in
            if !bool{
                print("error with JSON url - please check your id collection")
                return
            }
            
            self.items = widget.boxes!
            
            let holderView:UIView = UIView(frame: UIScreen.main.bounds)
            
            let rect = CGRect(x: 0.0, y: 40.0, width: Double(UIScreen.main.bounds.width), height: Double(self.items.count) * EngageyaTableViewCell.imageWidth)
            self.tableView = UITableView(frame: rect, style: .plain)
            self.tableView?.register(EngageyaTableViewCell.self, forCellReuseIdentifier: "box")
            self.tableView?.separatorStyle = .none
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            
            holderView.addSubview(self.titleLabel)
            holderView.addSubview(self.tableView!)

            DispatchQueue.main.async {
                print(widget.widgetTitle!)
                self.titleLabel.text = widget.widgetTitle
                compliation(holderView)
            }
            
        }
    }
    
    
    //TableView Overrides
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(EngageyaTableViewCell.imageWidth) - 5
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventManager.trigger(eventName: "tapped", information: items[indexPath.row].title)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let box = self.items[indexPath.row] as? EngageyaBox {
            let cell = self.tableView?.dequeueReusableCell(withIdentifier: "box", for: indexPath) as! EngageyaTableViewCell
            cell.tag = (indexPath as NSIndexPath).row
            cell.titleLabelMutual.text = String(htmlEncodedString: box.title)
            cell.countLabelMutual.text = String(htmlEncodedString: box.displayName)
            let thumbnailURL =  "https:\(box.thumbnail_path!)"
            getDataFromUrl(thumbnailURL) { data in
                DispatchQueue.main.async {
                    if(cell.tag == (indexPath as NSIndexPath).row) {
                        let image = UIImage(data: data!)
                        self.imageCache[String(box.thumbnail_path)] = image
                        cell.homeImageView.image = image
                        
                        let titlePositionRect = CGRect(x: cell.homeImageView.frame.size.width + cell.homeImageView.layer.position.x - 15, y: 10, width:UIScreen.main.bounds.width - (cell.homeImageView.layer.position.x + cell.homeImageView.bounds.width) , height: 30)
                        cell.titleLabelMutual.frame = titlePositionRect
                    }
                }
            }
            return cell
        }
    }

    
    
}
