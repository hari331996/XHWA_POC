//
//  DeviceList.swift
//  Home
//
//  Created by Nitin Akoliya on 20/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit

class DeviceList: NSObject, NSCoding {
    
    var deviceType: String
    var deviceId: String
    var deviceName: String
    var status: String
    var mediaType: String
    
//    init(data: JSON) {
//        deviceType = data["tags"].stringValue
//        deviceId = data["id"].stringValue
//        deviceName = data["name"].stringValue
//        status = data["status"].stringValue
//    }
    init(deviceType: String, deviceId: String, deviceName: String, status: String, mediaType: String) {
        self.deviceType = deviceType
        self.deviceId = deviceId
        self.deviceName = deviceName
        self.status = status
        self.mediaType = mediaType
    }
    required convenience init(coder aDecoder: NSCoder) {
        let deviceType = aDecoder.decodeObject(forKey: "deviceType") as! String
        let deviceId = aDecoder.decodeObject(forKey: "deviceId") as! String
        let deviceName = aDecoder.decodeObject(forKey: "deviceName") as! String
        let status = aDecoder.decodeObject(forKey: "status") as! String
        let mediaType = aDecoder.decodeObject(forKey: "mediaType") as! String
        self.init(deviceType: deviceType, deviceId: deviceId, deviceName: deviceName, status: status, mediaType: mediaType)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(deviceType, forKey: "deviceType")
        aCoder.encode(deviceId, forKey: "deviceId")
        aCoder.encode(deviceName, forKey: "deviceName")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(mediaType, forKey: "mediaType")
    }
}
