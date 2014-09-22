//
//  TodayViewController.swift
//  NextD-DayWidget
//
//  Created by honggu on 2014. 9. 11..
//  Copyright (c) 2014년 honggu. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
	@IBOutlet weak var DDay: UILabel!
	@IBOutlet weak var DDayDescription: UILabel!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		var ContentSize : CGSize = self.preferredContentSize
		NSLog("%f", ContentSize.height)
		ContentSize.height = 100
		self.preferredContentSize = ContentSize
		
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func Update()
	{
		let next = NextDDay()
		
		DDay.textAlignment = NSTextAlignment.Center
		DDay.text = "D-\(next.NextDayCounter())"
		DDay.font = UIFont.systemFontOfSize(20)
		var attr:NSMutableAttributedString = NSMutableAttributedString(attributedString: DDay.attributedText)
		attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range:NSMakeRange(2, String(next.NextDayCounter()).utf16Count))
		DDay.attributedText = attr
		
		let noti = UILocalNotification()
		noti.applicationIconBadgeNumber = next.NextDayCounter()
		
		DDayDescription.text = next.NextDayStr()
	}
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
		
		Update()

        completionHandler(NCUpdateResult.NewData)
    }
	
	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets
	{
		
		println("\(defaultMarginInsets.left) \(defaultMarginInsets.top) \(defaultMarginInsets.right) \(defaultMarginInsets.bottom)")
		return UIEdgeInsetsZero
	}
    
}
