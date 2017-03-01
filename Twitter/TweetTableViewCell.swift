
//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Apple on 2/27/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var photeImageView: UIImageView!
    @IBOutlet weak var profilenameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var tweet: Tweet!{
    didSet {
        profilenameLabel.text = tweet.name!
        usernameLabel.text = "@+\(tweet.screenname!)"
        timestampLabel.text = String(describing: tweet.timestamp!)
        contentLabel.text = tweet.text! as String?
        photeImageView.setImageWith(tweet.profileUrl!)
        }
    }
    @IBAction func pressRetweet(_ sender: Any) {
        TwitterClient.sharedInstance?.retweet(id: Int(tweet.id), success: { (tweet: Tweet) in
            self.tweet = tweet
            self.retweetButton.setImage(UIImage(named: "RetweetAfter"), for: .normal)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    @IBAction func pressLike(_ sender: Any) {
        TwitterClient.sharedInstance?.like(id: Int(tweet.id), success: { (tweet: Tweet) in
            self.tweet = tweet
            self.likeButton.setImage(UIImage(named: "LikeAfter"), for: .normal)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
