//
//  ViewController.swift
//  NextD-Day
//
//  Created by honggu on 2014. 9. 11..
//  Copyright (c) 2014년 honggu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
	@IBOutlet weak var DDayScrollView: UIScrollView!
	let next = NextDDay()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		DDayUiInit()
		RegisterNoti()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func GetBadgeNumberNextDay(index:(Int) = 0) ->Int
	{
		var BadgeNumber = 0
		if index == 0
		{
			BadgeNumber = next.NextDayCounter(index: index)
			
		}
		else
		{
			BadgeNumber = next.NextDayCounter(index: index) - next.NextDayCounter(index: index-1)
		}
		return BadgeNumber
	}
	
	func RegisterNoti()
	{
		let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
		UIApplication.sharedApplication().registerUserNotificationSettings(settings)
		
//		println("start")
		
		UIApplication.sharedApplication().applicationIconBadgeNumber = next.NextDayCounter()
		
		var notis = [UILocalNotification]()
		//d-day 갯수
		
		
		var currentDate:NSDateComponents  = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
		
		var datecomponet = NSDateComponents()
		datecomponet.day = currentDate.day
		datecomponet.month = currentDate.month
		datecomponet.year = currentDate.year
		println(NSCalendar.currentCalendar().dateFromComponents(datecomponet)!)
		
		
		var addDay = 0
		for i in 0..<next.CurrentNextDDayCount()
		{
			
			//날짜에 맞는 뱃지
			for j in 0..<GetBadgeNumberNextDay(index: i)
			{
				var local = UILocalNotification()
				
				let addcomponents:NSDateComponents = NSDateComponents()
				addcomponents.day = addDay;
				let newDate = NSCalendar.currentCalendar().dateByAddingComponents(addcomponents, toDate: NSCalendar.currentCalendar().dateFromComponents(datecomponet)! , options: nil)
				
				local.fireDate = newDate
				local.timeZone = NSTimeZone.defaultTimeZone()
				local.hasAction = false
				
				local.applicationIconBadgeNumber = GetBadgeNumberNextDay(index: i) - j
				notis.append(local)
				addDay++
			}
		}
		
		UIApplication.sharedApplication().scheduledLocalNotifications = notis
	}
	
	func DDayUiInit()
	{
		let next = NextDDay()
		var bound = UIScreen.mainScreen().bounds.size
		DDayScrollView.pagingEnabled = true
		DDayScrollView.alwaysBounceVertical = false
		DDayScrollView.alwaysBounceHorizontal = false
		DDayScrollView.directionalLockEnabled = true
		DDayScrollView.contentSize = CGSize(width: CGFloat(Int(bound.width) * next.CurrentNextDDayCount() ), height: 1)
		
		let size = CGSize(width: 300, height: 200)
		
		println(UIScreen.mainScreen())
		println(bound)
		println(DDayScrollView.contentSize)
		println(self.view)
		println(DDayScrollView)

		
//		println(next.CurrentNextDDayCount())
//		println("\(next.NextDayCounter())")
		for i in 0..<next.CurrentNextDDayCount()
		{
			var label1:UILabel = UILabel(frame: CGRect(x: bound.width/2 - size.width/2 + bound.width * CGFloat(i), y: bound.height/2 - size.height, width:size.width , height:size.height ))
			label1.textAlignment = NSTextAlignment.Center
			label1.text = "D-\(next.NextDayCounter(index: i))"
			label1.font = UIFont.systemFontOfSize(20)
			
			var label2:UILabel = UILabel(frame: CGRect(x: bound.width/2 - size.width/2 + bound.width * CGFloat(i), y: bound.height/2 + bound.height/5 - size.height/2, width:size.width , height:size.height ))
			label2.textAlignment = NSTextAlignment.Center
			label2.text = next.NextDayStr(index: i)
			
			var attr:NSMutableAttributedString = NSMutableAttributedString(attributedString: label1.attributedText)
			attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range:NSMakeRange(2, String(next.NextDayCounter(index: i)).utf16Count))
			label1.attributedText = attr
			
			DDayScrollView.addSubview(label1)
			DDayScrollView.addSubview(label2)
			
//			println("next \(i) : \(next.NextDayCounter(index:i))")
//			println("next \(i) : \(next.NextDayStr(index:i))")
		}
	}
}
