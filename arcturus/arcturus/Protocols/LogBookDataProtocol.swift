//
//  LogBookDataService.swift
//  Arcturus
//
//  Created by William Woolard on 8/2/14.
//  Copyright (c) 2014 coylums. All rights reserved.
//

import Foundation

protocol LogBookDataProtocol {

    class func getLogBookEntries() -> Array<LogEntry>

}
