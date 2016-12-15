//
//  ViewController.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/14/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import UIKit
import TwitterKit


class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                self.performSegue(withIdentifier: "showTimelineViewController", sender: sender)
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
    }
}

