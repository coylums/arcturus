//
//  LogEntry.m
//  arcturus
//
//  Created by William Woolard on 7/29/14.
//  Copyright (c) 2014 coylums. All rights reserved.
//

import CoreData

@objc(LogEntry)
class LogEntry : NSManagedObject {

    @NSManaged var date : NSDate
    @NSManaged var latitude : NSNumber
    @NSManaged var longitude : NSNumber
    @NSManaged var course : NSNumber
    @NSManaged var recordedBy : NSString
    @NSManaged var personAtHelm : NSString
    @NSManaged var sky : NSString
    @NSManaged var wind : NSString
    @NSManaged var barometer : NSNumber
    @NSManaged var conditions : NSString
    @NSManaged var temp : NSNumber?
    @NSManaged var comments : NSString

}