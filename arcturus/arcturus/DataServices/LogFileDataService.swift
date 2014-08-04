//
//  LogFileDataService.swift
//  Arcturus
//
//  Created by William Woolard on 8/2/14.
//  Copyright (c) 2014 coylums. All rights reserved.
//

import Foundation

class LogFileDataService: LogBookDataProtocol {

    class func getLogBookEntries() -> Array<LogEntry> {

        // Empty array to add LogEntry objects
        var logArray: Array<LogEntry> = [];

        var filePath = NSBundle.mainBundle().pathForResource("logbook", ofType:"json")

        var error: NSError? = nil

        // Load local JSON data
        var jsonData: NSData? = NSData.dataWithContentsOfFile(filePath, options: nil, error: &error)

        let json = JSONValue(jsonData)

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext

        for (index, element) in enumerate(json.array!) {

            let logEntry: LogEntry = NSEntityDescription.insertNewObjectForEntityForName("LogEntry", inManagedObjectContext: managedObjectContext) as LogEntry

            if var dateValue = json[index]["Date"].string{

                logEntry.date = DateHelper.parse(dateValue)

            }

            if var latitudeValue = json[index]["Latitude"].string{

                logEntry.latitude = latitudeValue.bridgeToObjectiveC().floatValue
                
            }

            if var longitudeValue = json[index]["Longitude"].string{

                logEntry.longitude = longitudeValue.bridgeToObjectiveC().floatValue

            }

            if var courseValue = json[index]["Course"].string{
                
                logEntry.course = courseValue.toInt()!
    
            }

            if var recordedByValue = json[index]["RecordedBy"].string{

                logEntry.recordedBy = recordedByValue

            }

            if var personAtHelmValue = json[index]["PersonAtHelm"].string{

                logEntry.personAtHelm = personAtHelmValue

            }

            if var windValue = json[index]["Wind"].string{

                logEntry.wind = windValue
                
            }

            if var barometerValue = json[index]["Barometer"].string{

                logEntry.barometer = barometerValue.toInt()!

            }

            if var conditionsValue = json[index]["Conditions"].string{

                logEntry.conditions = conditionsValue
                
            }

            if var skyValue = json[index]["Sky"].string{

                logEntry.sky = skyValue

            }

            if var tempValue = json[index]["Temp"].string{

                if(tempValue != nil || tempValue != "null") {

                    logEntry.temp = tempValue.toInt()!

                }
                
            }

            if var commentsValue = json[index]["Comments"].string{

                logEntry.comments = commentsValue

            }

            logArray.append(logEntry)

        }

        return logArray

    }

}