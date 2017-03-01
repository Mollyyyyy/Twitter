
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
        timestampLabel.text = timeAgoSince(tweet.timestamp!)
        contentLabel.text = tweet.text! as String?
        photeImageView.setImageWith(tweet.profileUrl!)
        }
    }
    func timeAgoSince(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
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
