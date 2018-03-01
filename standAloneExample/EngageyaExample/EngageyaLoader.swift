//
//  EngageyaLoader.swift
//  EngageyaExample
//
//  Created by Yuri Aleynikov on 28.02.2018.
//  https://github.com/aleyrobotics
//

import Foundation
import UIKit


public struct EngageyaBox {
    public var clickUrl:String!
    public var displayName:String!
    public var thumbnail_path:String!
    public var title:String!
    public var description: String!
    public var url:String!
}

public struct EngageyaWidget {
    public var boxes:[EngageyaBox]?
    public var widgetTitle:String?
}

public class EngageyaLoader : NSObject {
    
    // Variables
    public static var pubid:String?
    public static var webid:String?
    public static var widid:String?
    
    @discardableResult
    public init(pubid:String,webid:String,widid:String) {
        super.init()
        EngageyaLoader.pubid = pubid
        EngageyaLoader.webid = webid
        EngageyaLoader.widid = widid
    }
    
    class func createURL(url:String) -> String{
        let base_path:String = "https://recs.engageya.com/rec-api/getrecs.json?"
        var pubid = ""
        var webid = ""
        var widid = ""
        if let pud_id:String = EngageyaLoader.pubid as String? {
            // print("pub_id not defined")
            pubid = pud_id
        }
        if let web_id:String = EngageyaLoader.webid as String? {
            webid = web_id
        }
        if let wid_id:String = EngageyaLoader.widid as String?  {
            //print("wid_id not defined")
            widid = wid_id
        }
        
        let urlSample = ("\(base_path)pubid=\(pubid)&webid=\(webid)&wid=\(widid)&url=\(url)")
        return urlSample
    }
    
    class func getWidgetJSONResponse(siteUrl:String, compliation:@escaping (_ status:Bool, _ errString:String, _ widget : EngageyaWidget)->()){
        let url = URL(string: createURL(url:siteUrl))
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            let engWidget:EngageyaWidget?
            if error != nil {
                compliation(false, "\(String(describing: error))", EngageyaWidget())
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    var engBoxes:[EngageyaBox] = []
                    if let recs = parsedData["recs"] as? [[String: Any]]{
                        for(_,value) in recs.enumerated(){
                            var thumbnail_path:String?
                            if let thumbnailPath:String = value["thumbnail_path"] as? String {
                                thumbnail_path = thumbnailPath
                            }
                            var title:String?
                            if let titleValue:String = value["title"] as? String {
                                title = titleValue
                            }
                            var clickUrl:String?
                            if let clickURL:String = value["clickUrl"] as? String {
                                clickUrl = clickURL
                            }
                            var url:String?
                            if let URL:String = value["url"] as? String {
                                url = URL
                            }
                            // displayName can be optional (brand title)
                            var displayNameFinal:String?
                            if let displayName:String = value["displayName"] as? String {
                                displayNameFinal = displayName
                            }
                            var description: String?
                            if let descriptionText = value["description"] as? String {
                                description = descriptionText
                            }
                            
                            let box:EngageyaBox = EngageyaBox(clickUrl: clickUrl, displayName: displayNameFinal, thumbnail_path: thumbnail_path, title: title, description: description, url:url)
                            engBoxes.append(box)
                        }
                    }
                    if let widgetData = parsedData["widget"] as? [String:Any]{
                        if let headerText:String = widgetData["headerText"] as? String {
                            engWidget = EngageyaWidget(boxes: engBoxes, widgetTitle: headerText)
                            compliation(true, "", engWidget!)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                    compliation(false, "", EngageyaWidget(boxes: [], widgetTitle: "error"))
                }
            }
            }.resume()
    }
}

extension UIView {
    /// Adds constraints to the superview so that this view has same size and position.
    /// Note: This fails the build if the `superview` is `nil` – add it as a subview before calling this.
    func bindEdgesToSuperview(distance:CGFloat = 0.0) {
        guard let superview = superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `bindEdgesToSuperview()` to fix this.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        ["H:|-\(distance)-[subview]-\(distance)-|", "V:|-\(distance)-[subview]-\(distance)-|"].forEach { visualFormat in
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        }
    }
}


extension String {
    init(htmlEncodedString: String) {
        self.init()
        self = htmlEncodedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
