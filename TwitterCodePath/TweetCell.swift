//
//  TweetCell.swift
//  TwitterCodePath
//
//  Created by Nathan Miranda on 2/21/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var isFavorited = false
    var isRetweeted = false

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var faveLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 7
        profileImageView.clipsToBounds = true
        tweetLabel.sizeToFit()


    }
    
    var individualTweet: Tweet! {
        didSet {
            usernameLabel.text = "@\(individualTweet.user!.screenname!)"
            tweetLabel.text = "\(individualTweet.text!)"
            tweetLabel.sizeToFit()
            profileImageView.setImageWithURL(individualTweet.user!.profileUrl!)
            nameLabel.text = "\(individualTweet.user!.name!)"
            timeLabel.text = individualTweet.timeSince
            retweetLabel.text = String(individualTweet.retweetCount)
            faveLabel.text = String(individualTweet.favoritesCount)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(sender: AnyObject) {
        if !isRetweeted {
            isRetweeted = true
            retweetLabel.text = String(individualTweet.retweetCount + 1)
        }
        else {
            isRetweeted = false
            retweetLabel.text = String(individualTweet.retweetCount)
        }
        
    }
}
