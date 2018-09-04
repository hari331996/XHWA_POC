//
//  Device.swift
//  Home
//
//  Created by Nitin Akoliya on 28/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Foundation

class Device {

    let icon: String
    let deviceCategory: String
    let statePoint: String
   // var subCategories: Array<Any>
    
    init(deviceCategory: String, statePoint: String, icon: String) {
        self.icon = icon
        self.deviceCategory = deviceCategory
        self.statePoint = statePoint
    }
    
//    init(deviceCategory: String, statePoint: String, subCategories: Array<Any>) {
//        //self.icon = icon
//        self.deviceCategory = deviceCategory
//        self.statePoint = statePoint
//        self.subCategories = subCategories
//    }
    
//    required convenience init(coder aDecoder: NSCoder) {
//        let icon = aDecoder.de(forKey: "icon") as! UIImage
//        let statePoint = aDecoder.decodeObject(forKey: "statePoint") as! String
//        self.init(icon: icon, statePoint: statePoint)
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(icon, forKey: "icon")
//        aCoder.encode(statePoint, forKey: "statePoint")
//    }
    
}
