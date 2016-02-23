//
//  TweetCell.swift
//  TwitterCodePath
//
//  Created by Nathan Miranda on 2/21/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 5
        tweetLabel.sizeToFit()


    }
    
    var individualTweet: Tweet! {
        didSet {
            usernameLabel.text = "@\(individualTweet.user!.screenname!)"
            tweetLabel.text = "\(individualTweet.text!)"
            tweetLabel.sizeToFit()
            profileImageView.setImageWithURL(individualTweet.user!.profileUrl!)
            nameLabel.text = "\(individualTweet.user!.name!)"
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
