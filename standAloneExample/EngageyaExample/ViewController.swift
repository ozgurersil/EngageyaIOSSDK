//
//  ViewController.swift
//  EngageyaExample
//
//  Created by Yuri Aleynikov on 28.02.2018.
//  https://github.com/aleyrobotics
//

import UIKit

class ViewController: UIViewController, EngageyaAdView_delegate {

    @IBOutlet weak var adView: EngageyaAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = EngageyaLoader.init(pubid: "", webid: "", widid: "")// <<< PLACE IDs HERE
        adView.delegate = self
        adView.requestBanner(url: "http://www.example.com/somePage")// <<< PLACE URL FO HERE
    }
    
    func engageyaAdViewBox_click(box: EngageyaBox) {
        print("engageyaAdViewBox_click \(box)") // handle banner click here
    }
    
    func engageyaAdViewBox_ready(sender_adView: EngageyaAdView) {
        //banner ready for display
        sender_adView.renderView()
        sender_adView.contentHuggingPriority(for: UILayoutConstraintAxis(rawValue: 200)!)
        view.layoutSubviews()
    }
    
    func engageyaAdViewBox_fail(sender_adView: EngageyaAdView, status: Bool, errString: String) {
        //load fail
        print("status: \(status) err: \(errString)")
    }

}

