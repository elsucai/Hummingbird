//
//  TimelineViewController.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/14/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func prepareView() {
        let store = Twitter.sharedInstance().sessionStore
        let twtrSession = store.session() as? TWTRSession
        self.userName = (twtrSession?.userName)!
        self.dataSource = TWTRUserTimelineDataSource(screenName: self.userName, apiClient: client)
    }
    
    let client = TWTRAPIClient()
    var userName = ""
    
    @IBOutlet weak var listsButton: UIBarButtonItem!

    @IBAction func listsButtonTapped(_ sender: UIBarButtonItem) {
        self.dataSource = TWTRListTimelineDataSource(listSlug: "companies", listOwnerScreenName: "jack", apiClient: client)
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
