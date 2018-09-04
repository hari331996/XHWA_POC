//
//  DeviceData.swift
//  Home
//
//  Created by Nitin Akoliya on 28/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Foundation

class DeviceData {

    var device = [Device]()
    //var zoneCategory = [Zone]()

    
    init() {
//        zoneCategory.append(Zone(subCategory: "security", statePoint: ""))
//
//        zoneCategory.append(Zone(subCategory: "door", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "window", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "motion", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "smoke", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "carbonMonoxide", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "water", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "glassBreak", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "environmental", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "medical", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "duress", statePoint: "faulted"))
//
//        zoneCategory.append(Zone(subCategory: "panic", statePoint: "faulted"))
        let item = Device(deviceCategory: "Light", statePoint: "isOn", icon: "icon-light-off.png")
        device.append(item)
        
        device.append(Device(deviceCategory: "DoorLock", statePoint: "isOn", icon: "door-lock.png"))
        
        device.append(Device(deviceCategory: "Thermostat", statePoint: "systemStatus", icon: "thermo.png"))
        
        device.append(Device(deviceCategory: "Camera", statePoint: "*", icon: "camera.png"))
        
        device.append(Device(deviceCategory: "Peripheral", statePoint: "status", icon: "icon_settings_devices.png"))
        
        device.append(Device(deviceCategory: "Hub", statePoint: "scene", icon: "icon_settings_devices.png"))
        
        device.append(Device(deviceCategory: "Zone", statePoint: "faulted", icon: "icon-door-closed.png"))
    }

}
