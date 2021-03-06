//
//  MoreTabViewController.swift
//  Login Screen
//
//  Created by Disha Raval on 04/07/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class MoreTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cellContent = [String]()
    var identities = [String]()
    let defaults = UserDefaults.standard
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        firstly {
            ApiCalls().doLogout()
        }.done { responseData in
            UIViewController.removeSpinner(spinner: sv)
            //This is used to remove UserDefaults data
//            let domain = Bundle.main.bundleIdentifier!
//            UserDefaults.standard.removePersistentDomain(forName: domain)
//            UserDefaults.standard.synchronize()
            let loginVC = self.storyboard?.instantiateInitialViewController()
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = loginVC
        }.catch { error in
            UIViewController.removeSpinner(spinner: sv)
            let alert = UIAlertController(title: "Alert", message: "Logout failed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = cellContent[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = identities[indexPath.row]
        if vcName != "ManagePartnerServices" {
            print("Under Construction >>> " + vcName)
        }
        else {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: vcName)
            navigationController?.pushViewController(viewController!, animated: true)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cellContent = ["Manage Partner Services", "Account", "Contacts", "Application"]
        identities = ["ManagePartnerServices", "Account", "Contacts", "Application"]
        // Do any additional setup after loading the view.
        print("More Tab View Controller Loaded")
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
