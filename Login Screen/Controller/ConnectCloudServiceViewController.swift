//
//  ConnectCloudServiceViewController.swift
//  Home
//
//  Created by DJ on 11/09/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import UIKit

class ConnectCloudServiceViewController: UIViewController {
    var serviceID: String = ""
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Connecting \(serviceID)", message: "This will  redirect to partner auth Page. Work Under construction", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

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
