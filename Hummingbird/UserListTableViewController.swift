//
//  ListsTableViewController.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/15/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import UIKit
import TwitterKit

class UserListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userList = UserList()
        let session = Twitter.sharedInstance().sessionStore.session() as! TWTRSession
        self.userName = session.userName
        userList.getUserLists("abc", { (returnedLists: [ListItem]) -> Void in
            self.userLists = returnedLists
            self.userLists.insert(ListItem(slug: "All Tweets", name: "All Tweets", listOwnerName: self.userName), at: 0)
            self.tableView.reloadData()
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    var userLists = [ListItem]()
    var selectedListName = ""
    var selectedListSlug = ""
    var allTweetsSelected = false
    var userName = ""
    var selectedListOwnerName = ""

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text =  userLists[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedListName = userLists[indexPath.row].name
        self.selectedListSlug = userLists[indexPath.row].slug
        self.selectedListOwnerName = userLists[indexPath.row].listOwnerName
        self.allTweetsSelected = indexPath.row == 0
        _ = self.navigationController?.popViewController(animated: true)
        let timelineViewController = self.navigationController?.topViewController as! TimelineViewController
        timelineViewController.listSlug = self.allTweetsSelected ? "" : self.selectedListSlug
        timelineViewController.listOwnerName = self.allTweetsSelected ? self.userName : self.selectedListOwnerName
        timelineViewController.titleButton.setTitle(self.selectedListName, for: .normal)
        timelineViewController.viewDidLoad()
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
