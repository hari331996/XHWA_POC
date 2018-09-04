//
//  ActivityDataModelItem.swift
//  Home
//
//  Created by Nitin Akoliya on 08/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivityDataModelItem {
    
    var instanceId: String?
    var activityName: String?
    var date: String?
    
    init(data: JSON) {
        self.instanceId = data["instance"].stringValue
        let eventName: String? = data["mediaType"].stringValue
        self.activityName = getEventDescription(eventType: eventName!)
        if data["metaData"]["name"].stringValue == "eventTime" {
            self.date = data["metaData"]["value"].stringValue
        }
        
    }
    
    func getEventDescription(eventType: String) -> String {
        if eventType == "event/zoneTrouble" {
            
        }
        return "abc"
    }

}
