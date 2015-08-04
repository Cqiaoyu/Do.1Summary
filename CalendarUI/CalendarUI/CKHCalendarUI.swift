//
//  CKHCalendarUI.swift
//  CalendarUI
//
//  Created by LJ on 15/8/3.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit

var numberDaysOfMonth:Int!
class CKHCalendarUI: UIView,UICollectionViewDataSource,UICollectionViewDelegate{

    let calendar = NSCalendar.currentCalendar()
    
    var calendarUI:UICollectionView!
    var numberOfItems:Int!
    
    var currentYear:Int!
    var currentMonth:Int!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 350, height: 350)
        backgroundColor = UIColor.purpleColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func drawRect(rect: CGRect) {
        //calendarUI
        calendarUI = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 50), collectionViewLayout: CalendarCellLayout())
        calendarUI.delegate = self
        calendarUI.dataSource = self
        calendarUI.registerClass(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        calendarUI.backgroundColor = UIColor.orangeColor()
        addSubview(calendarUI)
        //dataSource
        let daysAndFirstLoacl = numberDaysOfMonthInYear(8, inYear: 2015)
        numberDaysOfMonth = daysAndFirstLoacl.numberDays
        let localOfFirstDay = daysAndFirstLoacl.localOfFirstDayInWeek
        let localOfLastDay = daysAndFirstLoacl.localOfLastDayInWeek
        println("\(numberDaysOfMonth)days")
        println("local in \(localOfFirstDay)")
        //reset number of items: get row numbers and then get item numbers
        numberOfItems = numberDaysOfMonth + (localOfFirstDay - 1) + (7 - localOfLastDay)
        
        
    }
    // MARK: - Data
    func numberDaysOfMonthInYear(month:Int? , inYear:Int?) -> (numberDays:Int,localOfFirstDayInWeek:Int,localOfLastDayInWeek:Int){
        //reset currentMonth/currentYear
        currentYear = inYear
        currentMonth = month
        println("currentMonth:\(currentMonth)")
        let calculateOfMonth = localOfTheFirstAndLastDayInMonth(currentMonth)!
        //get numberDaysOfMonth
        let numberOfDays = calculateOfMonth.numberOfDays
        //local of the first day
        let localOfFirst = calculateOfMonth.localOfFirstDayInWeek
        //local of the last day
        let localOfLast = calculateOfMonth.localOfLastDayInWeek
        return (numberOfDays,localOfFirst,localOfLast)
    }
    //local of the first day in the first week
    func localOfTheFirstAndLastDayInMonth(month:Int?) -> (numberOfDays:Int,localOfFirstDayInWeek:Int,localOfLastDayInWeek:Int)?{
        if let m = month{
            let firstDayStr = "\(currentYear)-0\(m)-01"
            
            let formmater = NSDateFormatter()
            formmater.dateFormat = "yyyy-MM-dd"
            
            let firstDate = formmater.dateFromString(firstDayStr)
            let range = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: firstDate!)
            let numberOfDays = range.length
            
            let lastDayStr = "\(currentYear)-0\(m)-\(numberOfDays)"
            let lastDate = formmater.dateFromString(lastDayStr)
            
            let localOfFirst = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitWeekOfMonth, forDate: firstDate!)
            let localOfLast = calendar.ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitWeekOfMonth, forDate: lastDate!)
            return (numberOfDays,localOfFirst,localOfLast)
        }
        return nil
    }
    
    // MARK: - UICollectionView DataSource Methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCell
        cell.backgroundColor = UIColor.greenColor()
        cell.title = String(indexPath.item + 1)
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

}

class CalendarCell: UICollectionViewCell {
    var title:String!
    override func drawRect(rect: CGRect) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        titleLabel.text = title
        titleLabel.textAlignment = .Center
        addSubview(titleLabel)
        
    }
}

class CalendarCellLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        minimumLineSpacing = 1.0
        minimumInteritemSpacing = 1.0
        itemSize = CGSize(width: (collectionView?.frame.size.width)!/8, height: 45)
    }
}
