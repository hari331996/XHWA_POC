//
//  ActivityTabViewController.swift
//  Login Screen
//
//  Created by Disha Raval on 04/07/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class ActivityTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
   
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var noActivityText: UILabel!
    let datePicker = UIDatePicker()
    let formatter = DateFormatter()
    var spinner: UIView = UIView()

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet weak var tableView: UITableView!
    fileprivate var activityArray = [ActivityDataModelItem]() {
        didSet {
            tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noActivityText.text = ""
        formatter.dateFormat = "yyyy-MM-dd"
        showDatePicker()
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        getActivityData()
    }

    func getActivityData() {
        spinner = UIViewController.displaySpinner(onView: self.view)
        firstly {
            ApiCalls().fetchActivityData(startDate: txtDatePicker.text!, endDate: txtDatePicker.text!)
        }.done { responseData in
            self.updateUI(json: responseData)
        }.catch { error in
            UIViewController.removeSpinner(spinner: self.spinner)
            let alert = UIAlertController(title: "Alert", message: "Failed to load Activity", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.noActivityText.alpha = 1
            self.tableView.alpha = 0
            self.noActivityText.text = "Nothing to display"
        }
    }
    
    func updateUI(json: JSON) {
        activityArray = [ActivityDataModelItem]()
        for item in json["entry"].arrayValue {
            let activityViewDataModelItem = ActivityDataModelItem(data: (item as? JSON)!)
            if activityViewDataModelItem.activityName != "event/thermostat" && (activityViewDataModelItem.instanceId != "" || activityViewDataModelItem.activityName == "event/armDisarm" || activityViewDataModelItem.activityName == "event/sceneUpdateEvent") {
                activityArray.append(activityViewDataModelItem)
            }
        }
        displayData()
    }
    
    func displayData() {
        UIViewController.removeSpinner(spinner: spinner)
        if activityArray.count == 0 {
            noActivityText.alpha = 1
            tableView.alpha = 0
            noActivityText.text = "Nothing to display"
        }
        else {
            tableView.alpha = 1
            noActivityText.alpha = 0
        }
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style:.plain, target: self, action: #selector(ActivityTabViewController.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ActivityTabViewController.donedatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
    }
    
    @objc func donedatePicker() {
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        getActivityData()
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm a"

        let date: Date?  = dateFormatterGet.date(from: activityArray[indexPath.row].date!)
        let dateString = dateFormatterPrint.string(from: date!)
        var subtext: String = ""
        if activityArray[indexPath.row].event == nil || activityArray[indexPath.row].event == ""{
            subtext = activityArray[indexPath.row].value! + ", Time: " +  dateString
        }
        else {
            subtext = activityArray[indexPath.row].event! + ":" + activityArray[indexPath.row].value! + ", Time: " +  dateString
        }
        if activityArray[indexPath.row].activityName == "event/armDisarm" || activityArray[indexPath.row].activityName == "event/sceneUpdateEvent" {
            let index = subtext.index(of: ",")!
            let spaceIndex = subtext.index(of: " ")!
            cell.textLabel?.text = String(subtext[..<index])
            cell.detailTextLabel?.text = String(subtext[subtext.index(after: spaceIndex)...])
        }
        else {
            cell.textLabel?.text = getDeviceNameById(Id: activityArray[indexPath.row].instanceId!)
            cell.detailTextLabel?.text = subtext
        }
        tableView.tableFooterView = UIView(frame: .zero)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func getDeviceNameById(Id: String) -> String {
        var deviceName: String = ""
        var deviceList = [DeviceList]()
        let decoded  = defaults.object(forKey: "deviceArray") as! Data
        deviceList = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [DeviceList]
        for device in 0..<deviceList.count {
            if deviceList[device].deviceId == Id {
                deviceName = deviceList[device].deviceName
            }
        }
        return deviceName
    }

}
