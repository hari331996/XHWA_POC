//
//  OverviewTabViewController.swift
//  Login Screen
//
//  Created by Disha Raval on 04/07/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import CoreData

class OverviewTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "Cell"
    let defaults = UserDefaults.standard
    var removedIndex: [Int] = []
    let deviceData = DeviceData()
    
    fileprivate var deviceList = [DeviceList]() {
        didSet {
            tableView?.reloadData()
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.text = deviceList[indexPath.row].deviceName
        cell.detailTextLabel?.text = deviceList[indexPath.row].status
        let icon = getIcon(deviceType: deviceList[indexPath.row].deviceType)
        cell.imageView?.image = UIImage(named: icon)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 75
        return cell
    }

    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
//        self.deviceList = defaults.object(forKey: "deviceArray") as? [String] ?? [String]()
        let decoded  = defaults.object(forKey: "deviceArray") as! Data
        self.deviceList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [DeviceList]
        for item in 0..<self.deviceList.count - 1 {
            if (self.deviceList[item].deviceType == "TouchScreen") || (self.deviceList[item].deviceType == "Hub") {
                self.deviceList.remove(at: item)
            }
        }
        print("Overview Tab View Controller Loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getIcon(deviceType: String) -> String {
        var icon: String = "icon_settings_devices.png"
        for i in 0..<deviceData.device.count {
            if deviceData.device[i].deviceCategory == deviceType {
                icon = deviceData.device[i].icon
            }
        }
        return icon;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
