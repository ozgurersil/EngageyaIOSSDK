//
//  EngageyaAdView.swift
//  EngageyaExample
//
//  Created by Yuri Aleynikov on 28.02.2018.
//  https://github.com/aleyrobotics
//

import Foundation
import UIKit
import Kingfisher

protocol EngageyaAdView_delegate: class {
    func engageyaAdViewBox_click(box: EngageyaBox)
    func engageyaAdViewBox_ready(sender_adView: EngageyaAdView)
    func engageyaAdViewBox_fail(sender_adView: EngageyaAdView, status:Bool, errString:String)
}

class EngageyaAdView: UIView, EngageyaAdViewBox_delegate, UITableViewDelegate, UITableViewDataSource {
    var widget: EngageyaWidget?
    var loaded: Bool = false
    weak var delegate: EngageyaAdView_delegate?
    var tableView: UITableView? = nil
    
    func requestBanner(url: String) {
        if tableView == nil {
            tableView = UITableView.init(frame: frame, style: .plain)
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(UINib.init(nibName: "EngageyaAdViewBoxCell", bundle: nil), forCellReuseIdentifier: "boxCell")
            addSubview(tableView!)
            tableView?.bindEdgesToSuperview()
            tableView?.isHidden = true
            tableView?.separatorStyle = .none
        }
        EngageyaLoader.getWidgetJSONResponse(siteUrl: url) { (status, errString, requestedWidget) in
            self.loaded = status
            if status == false {
                //request fail
                print("request fail")
            } else {
                //request sucess
                print("request sucess")
                self.widget = requestedWidget
                DispatchQueue.main.async {
                    self.delegate?.engageyaAdViewBox_ready(sender_adView: self)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if widget == nil {
            return 0
        }
        if widget?.boxes == nil {
            return 0
        }
        return (widget?.boxes?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let boxes = widget?.boxes!
        let box = boxes![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "boxCell") as! EngageyaAdViewBoxCell
        cell.label_title.text = box.title
        cell.label_description.text = box.description
        cell.label_description.setContentHuggingPriority(UILayoutPriority.fittingSizeLevel, for: .vertical)
        cell.label_description.setContentHuggingPriority(UILayoutPriority.fittingSizeLevel, for: .horizontal)
        cell.imageView_ico.kf.setImage(with: ImageResource.init(downloadURL: URL(string: "http:\(box.thumbnail_path!)")!))
        cell.box = box
        cell.delegate = self
        return cell
    }
    
    func renderView() {
        tableView?.isHidden = false
        tableView?.reloadData()
    }

    var renderedViewHeight: CGFloat {
        if tableView == nil {
            return 0
        }
        tableView?.layoutIfNeeded()
        return (tableView?.contentSize.height)!
    }
    
    func engageyaAdViewBox_click(box: EngageyaBox) {
        if delegate != nil {
            delegate?.engageyaAdViewBox_click(box: box)
        }
    }
}
