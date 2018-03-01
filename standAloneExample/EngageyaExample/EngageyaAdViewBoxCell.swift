//
//  EngageyaAdViewBox.swift
//  EngageyaExample
//
//  Created by Yuri Aleynikov on 28.02.2018.
//  https://github.com/aleyrobotics

import Foundation
import UIKit

protocol EngageyaAdViewBox_delegate: class {
    func engageyaAdViewBox_click(box: EngageyaBox)
}

class EngageyaAdViewBoxCell: UITableViewCell {
    @IBOutlet var imageView_ico: UIImageView!
    @IBOutlet var label_title: UILabel!
    @IBOutlet var label_description: UILabel!
    @IBOutlet var btn_Click: UIButton!
    
    var box: EngageyaBox?
    weak var delegate: EngageyaAdViewBox_delegate?
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if delegate != nil && box != nil {
            delegate!.engageyaAdViewBox_click(box: box!)
        }
    }
    
}
