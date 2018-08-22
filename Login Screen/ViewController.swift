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

class ViewController: UIViewController, UITextFieldDelegate {
    var commitPredicate: NSPredicate?
    let apiUrl = "https://pdev-n.icontrol.com/rest/icontrol/login"
    @IBOutlet weak var usernameView: UITextField!
    
    @IBOutlet weak var passwordView: UITextField!
    
    @IBOutlet weak var resultTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func doLogin(url: String) {
        let headers = ["X-login": String(usernameView.text!),
                       "X-password": String(passwordView.text!),
                       "X-AppKey": "defaultKey",
                       "X-expires": "6000000",
                       "Accept": "application/json; charset=UTF-8"]
        Alamofire.request(url, method: .get, headers: headers)
            .responseJSON {
                response in
                    if response.result.isSuccess {
                    let loginJSON : JSON = JSON(response.result.value!)
                    print(loginJSON)
                    if (loginJSON != "failed") {
                        let uname = loginJSON["login"]["displayName"].stringValue
                        print("Username:: \(uname)")
                        //to navigate to next page
                        self.performSegue(withIdentifier: "segueIdMain", sender: self)
                    }
                    else {
                        print("Login Failed!!")
                        self.resultTxt.alpha = 1
                        self.resultTxt.text = "Oops..Log In Failed!!"
                        //Alert View
                        let alert = UIAlertController(title: "Alert", message: "Login Failed..Invalid Credentials", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }

                }
                else {
                    print("Error \(String(describing: response.result.error))")
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        doLogin(url: apiUrl)
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
    
    //hide keyboard by pressing retun key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

