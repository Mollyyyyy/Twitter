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
    var profileUrl: URL?
    var tagline:String?
    var user: User!
    var dictionary: NSDictionary?
    var retweetcount:Int?
    var likecount: Int?
    var retweeted: Bool?
    var liked:Bool?
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        id = (dictionary["id"] as? Int)!
        name = user.name
        screenname = user.screenname
        profileUrl = user.profileUrl
        tagline = dictionary["description"] as? String
        text = dictionary["text"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        liked = dictionary["favorited"] as? Bool
        retweetcount = (dictionary["retweet_count"] as? Int) ?? 0
        likecount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String

        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
            print(timestamp as Any)
            
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
