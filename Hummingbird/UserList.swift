//
//  List.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/15/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import Foundation
import TwitterKit

struct ListItem {
    let slug: String
    let name: String
    let listOwnerName: String
    
}

class UserList {
    var client: TWTRAPIClient
    var getListsEndpoint: String
    
    init() {
        client = TWTRAPIClient()
        getListsEndpoint = "https://api.twitter.com/1.1/lists/list.json"
    }
    
    func getUserLists(_ userName: String, _ handle: @escaping ([ListItem]) -> Void) {
        let session = Twitter.sharedInstance().sessionStore.session()
        let userID = (session?.userID)!
        var clientError : NSError?
        let params = ["user_id": "\(userID)"]
        let request = client.urlRequest(withMethod: "GET", url: getListsEndpoint, parameters: params, error: &clientError)
        var res = [ListItem]()
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let array = json as? [Any] {
                    for item in array {
                        res.append(self.toListItem(item as! [String: Any]))
                    }
                }
                handle(res)
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    // convert a json string to ListItem
    func toListItem(_ json: [String: Any]) -> ListItem {
        let slug = json["slug"] as! String
        let name = json["name"] as! String
        let user = json["user"] as! [String: Any]
        let listOwnerName = user["screen_name"] as! String
        return ListItem(slug: slug, name: name, listOwnerName: listOwnerName)
    }
}
