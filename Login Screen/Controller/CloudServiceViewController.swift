//
//  CloudServiceViewController.swift
//  Home
//
//  Created by DJ on 07/09/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit

class CloudServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var serviceID: String = ""
    let defaults = UserDefaults.standard
    var deviceList = [DeviceList]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serviceName: UILabel!
    
    fileprivate var filterDeviceList = [DeviceList]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterDeviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = filterDeviceList[indexPath.row].deviceName
        cell.detailTextLabel?.text = filterDeviceList[indexPath.row].status
        let icon = "icon_settings_devices.png"
        cell.imageView?.image = UIImage(named: icon)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceName.text = serviceID.capitalized
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        let decoded  = defaults.object(forKey: "deviceArray") as! Data
        self.deviceList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [DeviceList]
        for item in 0..<self.deviceList.count {
            let deviceType = self.deviceList[item].deviceType.split(separator: "-")
            if deviceType[0] == serviceID {
                self.filterDeviceList.append(self.deviceList[item])
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
