//
//  TodayViewController.swift
//  NextD-DayWidget
//
//  Created by 국진 전 on 2014. 9. 11..
//  Copyright (c) 2014년 honggu. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
		var ContentSize : CGSize = self.preferredContentSize
		NSLog("%f", ContentSize.height)
		ContentSize.height = 100
		self.preferredContentSize = ContentSize
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
