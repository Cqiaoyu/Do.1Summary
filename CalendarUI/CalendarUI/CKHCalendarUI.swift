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

    var calendarUI:UICollectionView!
    let calendar = NSCalendar.currentCalendar()
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
        numberDaysOfMonth = numberDaysOfMonthInYear(2, inYear: 2015)
        println("\(numberDaysOfMonth)days")
        
        
    }
    // MARK: - Data
    func numberDaysOfMonthInYear(month:Int? , inYear:Int?) -> Int{
        var desMonth:NSDate!
        if let m = month{
            if let y = inYear{
                let dateStr = "\(y)-0\(m)-01"
                let formmater = NSDateFormatter()
                formmater.dateFormat = "yyyy-MM-dd"
                desMonth = formmater.dateFromString(dateStr)
            }
        }else{
            desMonth = NSDate()
            
        }
        //reset currentMonth
        currentMonth = calendar.component(NSCalendarUnit.CalendarUnitMonth, fromDate: desMonth)
        println("currentMonth:\(currentMonth)")
        //get numberDaysOfMonth
        let range = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: desMonth)
        return range.length
    }
    
    
    // MARK: - UICollectionView DataSource Methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCell
        cell.backgroundColor = UIColor.greenColor()
        cell.title = String(indexPath.item + 1)
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberDaysOfMonth
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
