//
//  Tweet.swift
//  Twitter
//
//  Created by Nathan Miranda on 2/7/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var timePassed: Int?
    var timeSince: String!
    var id: Int!
    var retweetCount: Int!
    var favoritedCount: Int!
    var retweeted: Bool!
    var favorited: Bool!
    
    var retweeted_status: Tweet?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as! Int
        
        retweetCount = dictionary["retweet_count"] as! Int
        favoritedCount = dictionary["favorite_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool
        
        if let retweeted_tweet = dictionary["retweeted_status"] as? NSDictionary {
            retweeted_status = Tweet.init(dictionary: retweeted_tweet)
            print("retweeted")
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        let now = NSDate()
        createdAt = formatter.dateFromString(createdAtString!)
        let then = createdAt
        timePassed = Int(now.timeIntervalSinceDate(then!))
        if timePassed >= 86400 {
            timeSince = String(timePassed! / 86400)+"d"
        }
        if (3600..<86400).contains(timePassed!) {
            timeSince = String(timePassed!/3600)+"h"
        }
        if (60..<3600).contains(timePassed!) {
            timeSince = String(timePassed!/60)+"m"
        }
        if timePassed < 60 {
            timeSince = String(timePassed!)+"s"
        }

    }
    
    // class func = public static method 
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
