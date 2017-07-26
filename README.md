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

Define connection with EngageyaIOSSDK with id's and set your dictionary keys with the desired values

```ruby
         self.engageya = EngageyaIOSSDK(pubid:"xxx",webid:"xxx",widid:"xxx")

         
         let appSettings:[String:Any] = [
                    "titlePaddingLeft":5,
                    "titlePaddingTop":0,
                    "imagePaddingLeft":2,
                    "imageWidth": 75,
                    "imageHeight": 50,
                    "tileHeight":120,
                    "fontFamily":UIFont.systemFont(ofSize: 13),
                    "fontSize": 13,
                    "widgetHeight" : 500,
                    "maxLines":3,
                    "fontColor": UIColor.black
                ]
```

Ready for getting widget data with method named `getWidgetData`

```ruby
         engageya.sharedCreatives().getWidgetData(idCollection: appId) { (widget:EngageyaWidget) in
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

```ruby 
       self.engageya.sharedCreatives().createListView(url: url,options: appSettings) { (widget:UIView) in
            self.view.addSubview(widget)
            self.engageya.getEventManager().listenTo(eventName: "tapped", action: self.clickAction)
       }
```

Structure of response `widget` `(UIView)`

![UITableView](https://github.com/ozgurersil/EngageyaIOSSDK/blob/master/tableview.png?raw=true)


CollectionView Usage 

```ruby 
       self.engageya.sharedCreatives().createCollectionView(url: url,options: appSettings) { (widget:UIView) in
            self.view.addSubview(widget)
            self.engageya.getEventManager().listenTo(eventName: "tapped", action: self.clickAction)
       }
```

Structure of response `widget` `(UIView)`

![UICollectionView](https://github.com/ozgurersil/EngageyaIOSSDK/blob/master/tableview.png?raw=true)

## Events

### Tap

```ruby
       self.engageya.getEventManager().listenTo(eventName: "tapped", action: self.clickAction)
```

```ruby 
      func clickAction(information:Any?){
              if let box = information as? EngageyaBox {
                  if let displayName = box.displayName {
                      print("this is an ad \(displayName)")
                      let url = "https:\(box.clickUrl!)"
                      if #available(iOS 9.0, *) {
                          let svc = SFSafariViewController(url: NSURL(string: url)! as URL)
                          self.present(svc, animated: true, completion: nil)
                      } else {
                          adWebview = UIViewController()
                          let webView:UIWebView = UIWebView(frame: UIScreen.main.bounds)
                          webView.delegate = self
                          webView.loadRequest(URLRequest(url: URL(string: url)!))
                          let newBackButton = UIButton(frame: CGRect(x: 5, y: 5, width: 30 , height: 30))
                          newBackButton.backgroundColor = UIColor.black
                          newBackButton.setTitle("X", for: .normal)
                          newBackButton.layer.cornerRadius = 2
                          newBackButton.addTarget(self, action: #selector(self.backPressed(sender:)), for: .touchDown)
                          adWebview?.view.addSubview(webView)
                          adWebview?.view.addSubview(newBackButton)
                          self.present(adWebview!, animated: true, completion: {
                              print("moved")
                          })
                      }
                   }
                  else{
                      print("this is not an ad \(box.url!)")
                  }
              }
      }

```
## Optional Params

```ruby
        static var imageWidth = 80.0
        
        static var imageHeight = 80.0
        
        static var imagePaddingLeft = 0.0
        
        static var imagePaddingTop = 0.0
        
        static var titlePaddingLeft = 0.0
        
        static var titlePaddingTop = 0.0
        
        static var tilePadding = 10.0
        
        static var tileRowCount = 2
        
        static var fontSize:Int?
        
        static var fontFamily:UIFont?
        
        static var widgetHeight:Int?
        
        static var tileHeight = 100.0
        
        static var maxLines = 2
        
        static var direction:Align = .vertical
        
        static var fontColor:UIColor = UIColor.black
```

## Author

ozgur, ozgur@engageya.com

## License

EngageyaIOSSDK is available under the MIT license. See the LICENSE file for more info.
