//
//  List.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/15/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import Foundation
import TwitterKit

class UserList {
    static let client = TWTRAPIClient()
    static let getListsEndpoint = "https://api.twitter.com/1.1/lists/list.json"
    
    static func getUserLists(_ userName: String) -> [String] {
        let session = Twitter.sharedInstance().sessionStore.session()
        let userID = (session?.userID)!
        var clientError : NSError?
        let params = ["user_id": "36960454"]
        let request = client.urlRequest(withMethod: "GET", url: getListsEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let array = json as! Array<Any>
                print("array: \(array)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
        return ["All Tweets", "List A", "List B"]
    }
}
