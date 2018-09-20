//
//  ViewController.swift
//  Login Screen
//
//  Created by Disha Raval on 02/07/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, UITextFieldDelegate {
    
   // var commitPredicate: NSPredicate?
    let defaults = UserDefaults.standard
    let deviceData = DeviceData()
    var deviceArray : [DeviceList] = []
    
    @IBOutlet weak var usernameView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var resultTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        var serverName = defaults.string(forKey: "serverName")
        if serverName == "" || serverName == nil {
            serverName = "beta.icontrol.com"
            self.defaults.set(serverName, forKey: "serverName")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        let spinner = UIViewController.displaySpinner(onView: self.view)
        firstly {
            ApiCalls().doLogin(username: usernameView.text!, password: passwordView.text!)
        }.done {
            responseData in
            UIViewController.removeSpinner(spinner: spinner)
            self.parseResponse(response: responseData)
        }.catch {
            error in
            UIViewController.removeSpinner(spinner: spinner)
            self.loginError(error: error)
        }
    }
    
    func parseResponse(response: JSON) {
        let loginJSON : JSON = response
        let uname = loginJSON["login"]["displayName"].stringValue
        for item in loginJSON["login"]["instances"]["instance"].arrayValue {
            let deviceObj = DeviceList(deviceType: item["tags"].stringValue, deviceId: item["id"].stringValue, deviceName: item["name"].stringValue, status: self.getDeviceStatus(point: item["points"].arrayValue, deviceType: item["tags"].stringValue), mediaType: item["mediaType"].stringValue)
            self.deviceArray.append(deviceObj)
        }
        
        self.defaults.setValue(uname, forKey: "Name")
        self.defaults.setValue(loginJSON["login"]["site"]["id"].stringValue, forKey: "siteId")
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.deviceArray)
        self.defaults.set(encodedData, forKey: "deviceArray")
        self.defaults.synchronize()
        
        //to navigate to next page
        self.performSegue(withIdentifier: "segueIdMain", sender: self)
    }
    
    func loginError(error: Error) {
        let alert = UIAlertController(title: "Alert", message: "Login Failed..Invalid Credentials", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDeviceStatus(point: [JSON], deviceType: String) -> String {
        var status: String = ""
        var statePoint: String = ""
        for i in 0..<deviceData.device.count {
            if deviceData.device[i].deviceCategory == deviceType {
                statePoint = deviceData.device[i].statePoint
            }
        }
        for key in point {
            for pointValue in key["point"].arrayValue {
                var mediaType = pointValue["mediaType"].stringValue
                let index = mediaType.index(of: "/")!
                mediaType = String(mediaType[mediaType.index(after: index)...]) //substring
                if mediaType == statePoint {
                    status = pointValue["text"].stringValue
                }
            }
        }
        return status;
    }
    
    @IBAction func helpBtnTapped(_ sender: UIButton) {
        print("Help Button Tapped")
    }
    
    @IBAction func tryDemoBtnTapped(_ sender: UIButton) {
        print("Just Curious? Try the Demo button Tapped..")
    }
    
    //hide keyboard by touching outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
