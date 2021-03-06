//
//  User.swift
//  Twitter
//
//  Created by Nathan Miranda on 2/7/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import SwiftString


var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {

    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var backgroundImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    var tweet_count: Int?
    var followers_count: Int?
    var following_count: Int?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        backgroundImageUrl = dictionary["profile_background_image_url"] as? String
        tagline = dictionary["description"] as? String
        tweet_count = dictionary["statuses_count"] as? Int
        followers_count = dictionary["followers_count"] as? Int
        following_count = dictionary["friends_count"] as? Int
        
        // grab high quality image
        if profileImageUrl?.containsString("_normal") == true {
            profileImageUrl = profileImageUrl?.stringByReplacingOccurrencesOfString("_normal", withString: "")
//            print("image url = \(profileImageUrl)")
        }

        if backgroundImageUrl?.containsString("_normal") == true {
            backgroundImageUrl = backgroundImageUrl?.stringByReplacingOccurrencesOfString("_normal", withString: "")
//            print("image url = \(backgroundImageUrl)")
        }
        
    }
    
    func stringLength(string: String) -> Int {
        return string.characters.count
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
        
    
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                let data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
}
