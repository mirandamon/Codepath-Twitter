//
//  LoginViewController.swift
//  TwitterCodePath
//
//  Created by Nathan Miranda on 2/18/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "y0MEbZ1StzbHbHs5ALMEgpy1H", consumerSecret: "tnfrewpVhxrp80KHOyPvsmHuP9uFQ9kHIm7GfIKxFx6uTH1hkJ")
        
        twitterClient.deauthorize()
        twitterClient.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twittercodepath://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
                print("I got a token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            }) {( error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
