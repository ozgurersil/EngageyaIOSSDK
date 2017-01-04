//
//  JSONRequestHandler.swift
//  Pods
//
//  Created by Engageya on 04/01/2017.
//
//
import UIKit

class JSONRequestHandler: NSObject {
    
    class func createURL(collections:[String:String]) -> String{
        let base_path:String = "https://premium.engageya.com/rec-api/getrecs.json?"
        
        guard let pud_id:String = collections["pub_id"]! as? String else {
            // print("pub_id not defined")
            
        }
        
        guard let web_id:String = collections["web_id"]! as? String else {
            print("web_id not defined")
            
        }
        
        guard let wid_id:String = collections["wid_id"]! as? String else {
            print("wid_id not defined")
            
        }
        
        guard let pageUrl:String = collections["url"]! as? String else {
            print("pageUrl not defined")
            
        }
        
        let url = "\(base_path)pubid=\(pud_id)&webid=\(web_id)&wid=\(wid_id)&url=\(pageUrl)"
        print(url)
        return url
    }
    
    
    class func makeHTTPRequest(url:String, compliation:@escaping (_ status:Bool, _ data : NSArray)->()){
        let url = URL(string: url)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "error with loading url : \(url)")
                compliation(false,[])
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    if let recs = parsedData["recs"] as? NSArray{
                        compliation(true,recs)
                    }
                    /*let currentTemperatureF = currentConditions["temperature"] as! Double
                     print(currentTemperatureF)*/
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
}
