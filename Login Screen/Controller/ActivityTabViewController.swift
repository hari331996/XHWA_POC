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

class ActivityTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
   
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet weak var tableView: UITableView!
    fileprivate var activityArray = [ActivityDataModelItem]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let serverName = defaults.string(forKey: "serverName") as! String
        let siteId = defaults.string(forKey: "siteId") as! String
        let apiUrl = "https://\(serverName)/rest/icontrol/sites/\(siteId)/eventsByDay"
        let params : [String : String] = ["startDate" : "2018-08-27", "maxResults" : "65536"]
        getActivityData(url: apiUrl, parameters: params)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getActivityData(url: String, parameters: [String: String]) {
        let headers = ["Accept": "application/json; charset=UTF-8"]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers)
        .responseJSON {
            response in
            if response.result.isSuccess {
                
                let activityJSON : JSON = JSON(response.result.value!)
                self.updateUI(json: activityJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func updateUI(json: JSON) {
        print("updateUI")
            for item in json["entry"].arrayValue {
                //var alarmStart = getAlarmStart(item: JSON);
                print(item)

                let activityViewDataModelItem = ActivityDataModelItem(data: (item as? JSON)!)
                activityArray.append(activityViewDataModelItem)
          
        }
    }

//    func getAlarmStart(item: JSON) {
//        var alarm;
//        if(typeof item.metaData !== 'undefined'){
//            var alarmStart = $filter('where')(event.metaData, {name:'alarmStartDate'});
//            if(alarmStart.length > 0){
//                if(typeof alarmStart[0].value != 'undefined'){
//                    alarm = alarmStart[0].value;
//                }
//            }
//        }
//        return alarm;
//    }
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = activityArray[indexPath.row].activityName
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
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
