//
//  Tweet.swift
//  Twitter
//
//  Created by Apple on 2/27/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id:Int = 0
    var name:String?
    var screenname: String?
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileUrl: URL?
    var tagline:String?
    init(dictionary: NSDictionary){
        id = (dictionary["id"] as? Int)!
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlSting = dictionary["profile_image_url_https"] as? String
        if let profileUrlSting = profileUrlSting{
            profileUrl = URL(string: profileUrlSting)
        }
        tagline = dictionary["description"] as? String

        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            timestamp = formatter.date(from: timestampString)
        }
    }
    class func tweetsWithArray(dictionaries:[NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
