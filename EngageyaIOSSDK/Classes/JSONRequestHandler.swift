//
//  JSONRequestHandler.swift
//  Pods
//
//  Created by Engageya on 04/01/2017.
//
//
import UIKit

class JSONRequestHandler: NSObject {
    
    class func createURL(url:String) -> String{
       let base_path:String = "https://recs.engageya.com/rec-api/getrecs.json?"
       var pubid = ""
       var webid = ""
       var widid = ""
       var pageUrl = ""
       if let pud_id:String = EngageyaIOSSDK.pubid as? String {
            // print("pub_id not defined")
            pubid = pud_id
       }
       if let web_id:String = EngageyaIOSSDK.webid as? String {
            webid = web_id
       }
       if let wid_id:String = EngageyaIOSSDK.widid as? String  {
            //print("wid_id not defined")
            widid = wid_id
       }
        
       if let page_Url:String = url as? String {
            //print("pageUrl not defined")
            pageUrl = page_Url
       }
       let url = ("\(base_path)pubid=\(pubid)&webid=\(webid)&wid=\(widid)&url=\(pageUrl)")
       return url
    }
    
    
   
    class func getWidgetJSONResponse(url:String, compliation:@escaping (_ status:Bool, _ widget : EngageyaWidget)->()){
        let url = URL(string: url)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            let engWidget:EngageyaWidget?
            if error != nil {
                print(error ?? "error with loading url : \(url)")
                compliation(false, EngageyaWidget(boxes: [], widgetTitle: "error"))
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    var engBoxes:[EngageyaBox] = []
                    if let recs = parsedData["recs"] as? NSArray{
                        for(index,value) in recs.enumerated(){
                            var thumbnail_path:String?
                            if let thumbnailPath:String = (value as AnyObject)["thumbnail_path"] as? String {
                                thumbnail_path = String(htmlEncodedString:thumbnailPath)
                            }
                            var title:String?
                            if let titleValue:String = (value as AnyObject)["title"] as? String {
                                title = String(htmlEncodedString:titleValue)
                            }
                            var clickUrl:String?
                            if let clickURL:String = (value as AnyObject)["clickUrl"] as? String {
                                clickUrl = String(htmlEncodedString: clickURL)
                            }
                            var url:String?
                            if let URL:String = (value as AnyObject)["url"] as? String {
                                url = String(htmlEncodedString: URL)
                            }
                            // displayName can be optional (brand title)
                            var displayNameFinal:String?
                            if let displayName:String = (value as AnyObject)["displayName"] as? String {
                                displayNameFinal = displayName
                            }
                            
                            let box:EngageyaBox = EngageyaBox(clickUrl: clickUrl, displayName: displayNameFinal, thumbnail_path: thumbnail_path, title: title,url:url)
                            engBoxes.append(box)
                        }
                    }
                    if let widgetData = parsedData["widget"] as? [String:Any]{
                        if let headerText:String = widgetData["headerText"] as? String {
                            engWidget = EngageyaWidget(boxes: engBoxes, widgetTitle: headerText)
                            compliation(true, engWidget!)
                        }
                    }
                } catch let error as NSError {
                    //print(error)
                    compliation(false, EngageyaWidget(boxes: [], widgetTitle: "error"))
                }
            }
        }.resume()
    }
}
