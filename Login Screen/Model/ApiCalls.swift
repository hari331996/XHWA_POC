//
//  ApiCalls.swift
//  Home
//
//  Created by Nitin Akoliya on 18/09/18.
//  Copyright © 2018 Heena Dave. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class ApiCalls {
    let defaults = UserDefaults.standard
    
    func doCall(url: String, parameters: [String: String]?, headers: [String: String]?) -> Promise<JSON> {
        
        let serverName = defaults.string(forKey: "serverName")
        var apiUrl: String = ""
        if let server = serverName {
            apiUrl = "https://\(server)\(url)"
        }
        
        return Promise { seal in
            
            if parameters == nil && headers == nil {
                Alamofire.request(apiUrl, method: .get)
                    .validate()
                    .responseString {response in
                        if response.result.isSuccess {
                            seal.fulfill(JSON(response.result.value!))
                        }
                        else {
                            seal.reject(response.error!)
                        }
                }
            }
            else {
                Alamofire.request(apiUrl, method: .get,parameters: parameters, headers: headers)
                    .validate()
                    .responseJSON {response in
                        if response.result.isSuccess {
                            seal.fulfill(JSON(response.result.value!))
                        }
                        else {
                            seal.reject(response.error!)
                        }
                }
            }
        }
    }
    
    public func doLogin(username: String, password: String) -> Promise<JSON> {
        let headers = ["X-login": username,
                       "X-password": password,
                       "X-AppKey": "defaultKey",
                       "X-expires": "6000000",
                       "Accept": "application/json; text/plain; */*"]
        let params : [String : String] = ["expand" : "sites,instances,points,functions"]
        
        return Promise { seal in
            firstly {
                doCall(url: "/rest/icontrol/login", parameters: params, headers: headers)
            }.done { response in
                seal.fulfill(response)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func doLogout() -> Promise<JSON> {
        return Promise { seal in
            firstly {
                doCall(url: "/rest/icontrol/logout", parameters: nil, headers: nil)
                }.done { response in
                    seal.fulfill(response)
                }.catch { error in
                    seal.reject(error)
            }
        }
    }
    
    public func fetchActivityData(startDate: String, endDate: String) -> Promise<JSON> {
        let headers = ["Accept": "application/json; text/plain; */*"]
        let params : [String : String] = ["startDate" : startDate, "endDate" : endDate, "maxResults" : "65536"]
        let siteId = self.defaults.string(forKey: "siteId")
        
        return Promise { seal in
            firstly {
                doCall(url: "/rest/icontrol/sites/\(siteId!)/eventsByDay", parameters: params, headers: headers)
            }.done { response in
                seal.fulfill(response)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}
