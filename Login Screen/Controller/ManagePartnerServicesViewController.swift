//
//  ManagePartnerServicesViewController.swift
//  Home
//
//  Created by DJ on 22/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ManagePartnerServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var partnerList = [String]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return partnerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = partnerList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        let serverName = defaults.value(forKey: "serverName") as! String
        let apiUrl = "https://\(serverName)/rest/icontrol"
        fetchPartner(url: apiUrl)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchPartner(url: String) {
        let siteId = defaults.string(forKey: "siteId") as! String
        let api = url + "/sites/\(siteId)/partnerNames"
        let headers = ["Accept": "application/json; charset=UTF-8"]
        Alamofire.request(api, method: .get, headers: headers)
            .responseString() {
                response in
                if response.result.isSuccess {
                    let loginJSON: String = response.result.value!
                    self.partnerList = loginJSON.components(separatedBy: ",")
                    print(self.partnerList)
                }
                else {
                    print("Error \(String(describing: response.result.error))")
                }
        }
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
