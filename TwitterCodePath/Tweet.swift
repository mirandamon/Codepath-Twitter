//
//  Tweet.swift
//  TwitterCodePath
//
//  Created by Nathan Miranda on 2/21/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var createdDate: NSDate?
    var timePassed: Int?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        let timestampString = dictionary["created_at"] as? String

        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            let current = NSDate()
            let past = timestamp
            timePassed = Int(current.timeIntervalSinceDate(past!))
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
                let tweet = Tweet(dictionary: dictionary)
                tweets.append(tweet)
        }
        return tweets
    }

}
