//
//  ViewController.swift
//  Login Screen
//
//  Created by Disha Raval on 02/07/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    var commitPredicate: NSPredicate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Save Data to Core Data Database
        print("Login Controller Loaded")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(3, forKey: "id")
        newUser.setValue("einfo", forKey: "name")
        newUser.setValue("1234", forKey: "password")
        
        do {
            try context.save()
            print("Data Saved Successfully")
        } catch {
            print("Failed to save data")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var usernameView: UITextField!
    
    @IBOutlet weak var passwordView: UITextField!
    
    @IBOutlet weak var resultTxt: UILabel!
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Users")
        request.predicate = commitPredicate
//        request.predicate = NSPredicate(format: "username < %@", "Heena")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") as? String, let password = result.value(forKey: "password") as? String {
                    if username == usernameView.text!, password == passwordView.text! {
                        print("Login Successful")
                        
                        //to navigate to next page
                        self.performSegue(withIdentifier: "segueIdMain", sender: self)
                    }
                    else {
                        print("Login Failed!!")
                        resultTxt.alpha = 1
                        resultTxt.text = "Oops..Log In Failed!!"
                        
                        //Alert View
                        let alert = UIAlertController(title: "Alert", message: "Login Failed..Invalid Credentials", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } catch {
            
        }
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

