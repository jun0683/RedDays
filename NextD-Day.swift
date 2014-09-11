//
//  NextD-Day.swift
//  NextD-Day
//
//  Created by 국진 전 on 2014. 9. 11..
//  Copyright (c) 2014년 honggu. All rights reserved.
//

import Foundation
/*

https://mirror.enha.kr/wiki/%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD/%EB%B2%95%EC%A0%95%20%EA%B3%B5%ED%9C%B4%EC%9D%BC

일요일
신정 (1월 1일)
설날연휴 (음력 1월 1일을 전후한 3일) (설날 전날, 설날, 설날 다음날 (음력 12월 말일, 1월 1일, 2일))
삼일절 (3월 1일) ★
어린이날 (5월 5일)
석가탄신일 (음력 4월 8일)
현충일 (6월 6일)
광복절 (8월 15일) ★
추석연휴 (음력 8월 15일을 전후한 3일)(추석 전날, 추석, 추석 다음날 (음력 8월 14일, 15일, 16일))
개천절 (10월 3일) ★
한글날 (10월 9일) ★ (1991년 제외 후 2013년부터 공휴일로 복귀)
성탄절 (12월 25일)

*/

extension String {
	func toDate(let format:String = "dd/MM/yyyy") -> NSDate? {
	var formatter:NSDateFormatter = NSDateFormatter()
	formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
	formatter.timeZone = NSTimeZone()
	formatter.dateFormat = format
	
	return formatter.dateFromString(self)
	}
}

class NextDDay
{
	let restdays = ["1/1/2014".toDate(),"1/3/2014".toDate(),"5/5/2014".toDate(),"6/6/2014".toDate(),"15/8/2014".toDate(),"3/10/2014".toDate(),"9/10/2014".toDate(),"25/12/2014".toDate()]
	
	
	func NextD() -> NSInteger
	{
		var currentDate:NSDateComponents  = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
		for restday in restdays
		{
			var restDate:NSDateComponents  = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate:restday)
	
			if NSDate().timeIntervalSince1970 <= restday?.timeIntervalSince1970
			{
				println("month \(currentDate.month) \(restDate.month)")
				println("day \(currentDate.day) \(restDate.day)")
		
				return NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit, fromDate: NSDate(), toDate: restday, options: nil).day
			}
		}
		return 0
	}
	
}
