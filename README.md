# EngageyaIOSSDK

[![CI Status](http://img.shields.io/travis/ozgur/EngageyaIOSSDK.svg?style=flat)](https://travis-ci.org/ozgur/EngageyaIOSSDK)
[![Version](https://img.shields.io/cocoapods/v/EngageyaIOSSDK.svg?style=flat)](http://cocoapods.org/pods/EngageyaIOSSDK)
[![License](https://img.shields.io/cocoapods/l/EngageyaIOSSDK.svg?style=flat)](http://cocoapods.org/pods/EngageyaIOSSDK)
[![Platform](https://img.shields.io/cocoapods/p/EngageyaIOSSDK.svg?style=flat)](http://cocoapods.org/pods/EngageyaIOSSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

IOS8 or higher


## Installation

EngageyaIOSSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
       pod "EngageyaIOSSDK"
```

## Usage

After pod install, simply add EngageyaIOSSDK with:

```ruby
       import EngageyaIOSSDK
```

Define connection with EngageyaIOSSDK and set your dictionary keys with the desired values

```ruby
        let engageya:EngageyaIOSSDK = EngageyaIOSSDK() 

        let appId:[String:Any] = [
            "pub_id" : "xxx", (required)
            "web_id" : "xxx", (required)
            "wid_id" : "xxx", (required)
            "url" : "http://www.xxx.com/spor/futbol/haber/938402-ultraslandan-tffye-cikarma", (required)
            "imageWidth": 70, (optional)
            "imageHeight": 70, (optional)
            "fontSize": 12, (optional)
            "tilePadding": 5 (optional)
        ]
```

Ready for getting widget data with method named `getWidgetData`

```ruby
         engageya.getWidgetData(idCollection: appId) { (widget:EngageyaWidget) in
                print("widgetTitle : \(widget.widgetTitle!)") // title of the widget
                print("recs: \(widget.boxes!)") // Array of widget elements 
         }
```

Structure of response `EngageyaWidget` & `EngageyaBox`

```ruby
        EngageyaWidget {
            var boxes:[EngageyaBox]
            var widgetTitle:String
        }
        
        EngageyaBox {
            var clickUrl:String
            var displayName:String
            var thumbnail_path:String
            var title:String
        }
```


TableView Usage 

``` self.engageya.createListView(idCollection: appId) { (widget:UIView) in
            holder.addSubview(widget)
        }
```

Structure of response `widget` `(UIView)`


Events

Tapped:

```self.engageya.eventManager.listenTo(eventName: "tapped", action: self.clickAction)
```

``` func clickAction(information:Any?){
        if let box = information as? EngageyaBox {
            if let displayName = box.displayName {
                print("this is an ad \(displayName)")
                let webView = UIWebView(frame: UIScreen.main.bounds)
                if #available(iOS 9.0, *) {
                    webView.allowsLinkPreview = true
                } else {
                    // Fallback on earlier versions
                }
                webView.delegate = self
                view.addSubview(webView)
                let url = "https:\(box.clickUrl!)"
                let encoded_url = URL(string: url)!
                webView.loadRequest(URLRequest(url: encoded_url))
    
            }
            else{
                print("this is not an ad \(box.clickUrl)")
            }
        }
    }
```






## Author

ozgur, ozgur@engageya.com

## License

EngageyaIOSSDK is available under the MIT license. See the LICENSE file for more info.
