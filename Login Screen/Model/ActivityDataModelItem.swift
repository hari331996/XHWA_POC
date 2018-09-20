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
    
    var event: String?
    var value: String?
    var instanceId: String?
    var activityName: String?
    var date: String?
    
    init(data: JSON) {
        self.event = data["name"].stringValue
        self.value = data["value"].stringValue
        self.instanceId = data["instance"].stringValue
        let eventName: String? = data["mediaType"].stringValue
        self.activityName = eventName
        for item in data["metaData"].arrayValue {
            if item["name"].stringValue == "eventTime" {
                self.date = item["value"].stringValue
            }
        }
        
        if (activityName == "event/onDemandImage") {
            for item in data["metaData"].arrayValue {
                if item["name"].stringValue == "cameraInstanceIds" {
                    var id = item["value"].stringValue
                    let index = id.index(of: ",")!
                    self.instanceId = String(id[..<index])
                    
                }
            }
        }
        
        
    }
    
//    func getEventDescription(eventType: String) -> String {
//        if eventType == "event/zoneTrouble" {
//
//        }
//        return "abc"
//    }

}
