//
//  DateHelper.swift
//  Arcturus
//
//  Created by William Woolard on 8/3/14.
//  Copyright (c) 2014 coylums. All rights reserved.
//

import Foundation

class DateHelper {

    class func from(#year:Int, month:Int, day:Int) -> NSDate {

        var c = NSDateComponents()

        c.year = year
        c.month = month
        c.day = day

        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        var date = gregorian.dateFromComponents(c)

        return date

    }

    class func parse(dateStr:String, format:String="yyyy-MM-dd") -> NSDate {

        var dateFmt = NSDateFormatter()

        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format

        return dateFmt.dateFromString(dateStr)

    }
}