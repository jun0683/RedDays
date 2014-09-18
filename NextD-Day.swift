//
//  NextD-Day.swift
//  NextD-Day
//
//  Created by honggu on 2014. 9. 11..
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
		formatter.locale = NSLocale(localeIdentifier: "ko_KR")
		formatter.timeZone = NSTimeZone()
		formatter.dateFormat = format
		
		return formatter.dateFromString(self)
	}
}

extension NSDate {
	func WeekDay() -> String
	{
		let formatter = NSDateFormatter()
		formatter.locale = NSLocale(localeIdentifier: "ko_KR")
		formatter.dateFormat = "E"
		return formatter.stringFromDate(self)

	}
}

class DDay : NSObject
{
	var date:NSDate
	var str:NSString
	init(date:NSDate ,str:NSString)
	{
		self.date = date
		self.str = str
	}
	
	override var description: String {
		return "\(date) \(str)"
	}
}

class NextDDay
{
	var restdays = Array<DDay>()
	var man = Manse()
	
	init()
	{
		var currentDate:NSDateComponents  = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
		
		restdays.append(MakeDDay(currentDate.year, month: 1, day: 1, str: "신정"))
		restdays.append(MakeDDay(currentDate.year+1, month: 1, day: 1, str: "신정"))
		restdays.append(MakeDDay(currentDate.year, month: 3, day: 1, str: "삼일절"))
		restdays.append(MakeDDay(currentDate.year, month: 5, day: 5, str: "어린이날"))
		restdays.append(MakeDDay(currentDate.year, month: 6, day: 6, str: "현충일"))
		restdays.append(MakeDDay(currentDate.year, month: 8, day: 15, str: "광복절"))
		restdays.append(MakeDDay(currentDate.year, month: 10, day: 3, str: "개천절"))
		restdays.append(MakeDDay(currentDate.year, month: 10, day: 9, str: "한글날"))
		restdays.append(MakeDDay(currentDate.year, month: 12, day: 25, str: "성탄절"))
		man.Lun2Sol(currentDate.year, m: 1, d: 1)
		restdays.append(MakeDDay(man.sy, month: man.sm, day: man.sd, str: "설날"))
		man.Lun2Sol(currentDate.year+1, m: 1, d: 1)
		restdays.append(MakeDDay(man.sy, month: man.sm, day: man.sd, str: "설날"))
		man.Lun2Sol(currentDate.year, m: 4, d: 8)
		restdays.append(MakeDDay(man.sy, month: man.sm, day: man.sd, str: "석가탄신일"))
		man.Lun2Sol(currentDate.year, m: 8, d: 15)
		restdays.append(MakeDDay(man.sy, month: man.sm, day: man.sd, str: "추석"))
		restdays.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
//		println(restdays)
	}
	
	func MakeDDay(yaer:Int ,month:Int ,day:Int ,str:String)->DDay
	{
		let d:NSDate = "\(String(day))/\(String(month))/\(String(yaer))".toDate()!
		
		return DDay(date: d, str: "\(String(yaer))/\(String(month))/\(String(day))(\(String(d.WeekDay()))) \(str)")
	}
	
	func CurrentNextDDayCount()->Int
	{
		return restdays.count - NextDDayIndex()
	}
	
	func NextDDayIndex()->Int
	{
		var i:Int = 0
		for restday in restdays
		{
			var restDate:NSDateComponents  = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate:restday.date)
			
			if NSDate().timeIntervalSince1970 <= restday.date.timeIntervalSince1970
			{
				return i
			}
			i++
		}
		return 0
	}
	
	func NextDayCounter(var index:Int=0) -> Int
	{
		var restday = restdays[NextDDayIndex()+index]
		
		return NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit, fromDate: NSDate(), toDate: restday.date, options: nil).day+1
	}
	
	func NextDayStr(var index:Int=0) -> String
	{
		return restdays[NextDDayIndex()+index].str
	}
}
