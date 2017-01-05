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

        let appId:[String:String] = [
            "pub_id" : "xxxxxx",
            "web_id" : "xxxxxx",
            "wid_id" : "xxxxxx",
            "url" : "http://xxx.com/xxx/938402-xxx-xx-xxxx"
        ]
```

Ready for getting widget data with method named `getWidgetData`

```ruby
         engageya.getWidgetData(idCollection: appId) { (widget:EngageyaWidget) in
                print("widgetTitle : \(widget.widgetTitle!)") // title of the widget
                print("recs: \(widget.boxes!)") // Array of widget elements 
         }
```

Structure of response EngageyaWidget & EngageyaBox

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

## Author

ozgur, ozgur@engageya.com

## License

EngageyaIOSSDK is available under the MIT license. See the LICENSE file for more info.
