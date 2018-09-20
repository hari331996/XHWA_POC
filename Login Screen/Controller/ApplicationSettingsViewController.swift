//
//  ApplicationSettingsViewController.swift
//  Home
//
//  Created by Nitin Akoliya on 24/08/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit

class ApplicationSettingsViewController: UIViewController {

    @IBOutlet weak var serverUrlText: UITextField!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverUrlText.text = defaults.string(forKey: "serverName")
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    @IBAction func setServerUrl(_ sender: UIButton) {
        if serverUrlText.text != "" {
            let confirmAlert = UIAlertController(title: "", message: "Server is successfully saved", preferredStyle: UIAlertControllerStyle.alert)
            confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                self.defaults.set(self.serverUrlText.text!, forKey: "serverName")
                let viewController = self.storyboard?.instantiateInitialViewController()
                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDel.window?.rootViewController = viewController
            }))
            present(confirmAlert, animated: true, completion: nil)
        }
        else {
            let confirmAlert = UIAlertController(title: "", message: "Please enter valid server url", preferredStyle: UIAlertControllerStyle.alert)
            confirmAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(confirmAlert, animated: true, completion: nil)
        }
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
