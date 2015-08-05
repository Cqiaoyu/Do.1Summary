//
//  ViewController.swift
//  CalendarUI
//
//  Created by LJ on 15/8/3.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calendar = NSCalendar.currentCalendar()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        calendar.locale = NSLocale(localeIdentifier: "zh_CN")
        println(calendar.firstWeekday)
        println(calendar.minimumDaysInFirstWeek)
        println(calendar.weekdaySymbols)
        println(calendar.monthSymbols)
        println(calendar.standaloneMonthSymbols)
        println(calendar.eraSymbols)
        println(calendar.quarterSymbols)
        println(calendar.calendarIdentifier)
        println(calendar.minimumRangeOfUnit(NSCalendarUnit.CalendarUnitMonth))
        println(calendar.maximumRangeOfUnit(NSCalendarUnit.CalendarUnitMonth))
        println(calendar.startOfDayForDate(NSDate()))
        println(calendar.minimumRangeOfUnit(NSCalendarUnit.CalendarUnitDay))
        println(calendar.maximumRangeOfUnit(NSCalendarUnit.CalendarUnitDay))
        println("最小年范围\(calendar.minimumRangeOfUnit(NSCalendarUnit.CalendarUnitYear))")
        println("最大年范围\(calendar.maximumRangeOfUnit(NSCalendarUnit.CalendarUnitYear))")
        let str = "2015-08-01"
        let formmat = NSDateFormatter()
        formmat.dateFormat = "yyyy-MM-dd"
        let february = formmat.dateFromString(str)
        println(calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: february!))//指定日期的月份的范围
        println(calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitWeekOfMonth, forDate: february!))//日所在星期中的第几天
        
        let ui = CKHCalendarUI(frame: CGRect(x: 10, y: 30, width: 0, height: 0))
        view.addSubview(ui)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

