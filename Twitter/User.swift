
//
//  User.swift
//  Twitter
//
//  Created by Apple on 2/27/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String?
    var screenname: String?
    var profileUrl: URL?
    var backgroundUrl: URL?
    var text: String?
    var tagline:String?
    var dictionary: NSDictionary?
    var timestamp: Date?
    var retweetcount:Int?
    var likecount: Int?
    var retweeted: Bool?
    var liked:Bool?
    var followingcount: Int?
    var followerscount: Int?
    var tweetscount: Int?
    var followingNum: String {
        get {
            if followingcount! >= 1000000 {
                return "\(Int(followingcount!/100000))m"
            } else if followingcount! >= 1000 {
                return "\(Int(followingcount!/100))k"
            } else {
                return "\(followingcount!)"
            }
        }
    }
    var followersNum: String {
        get {
            if followerscount! >= 1000000 {
                return "\(Int(followerscount!/100000))m"
            } else if followerscount! >= 1000 {
                return "\(Int(followerscount!/100))k"
            } else {
                return "\(followerscount!)"
            }
        }
    }
    
    var tweetsNum: String {
        get {
            if tweetscount! >= 1000000 {
                return "\(Int(tweetscount!/100000))m"
            } else if tweetscount! >= 1000 {
                return "\(Int(tweetscount!/100))k"
            } else {
                return "\(tweetscount!)"
            }
        }
    }
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        followingcount = (dictionary["friends_count"] as! Int)
        followerscount = (dictionary["followers_count"] as! Int)
        tweetscount = (dictionary["statuses_count"] as! Int)
        text = dictionary["text"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        liked = dictionary["favorited"] as? Bool
        retweetcount = (dictionary["retweet_count"] as? Int) ?? 0
        likecount = (dictionary["favorite_count"] as? Int) ?? 0
        tagline = dictionary["description"] as? String
        let profileUrlSting = dictionary["profile_image_url_https"] as? String
        if let profileUrlSting = profileUrlSting{
            profileUrl = URL(string: profileUrlSting)
        }
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundUrl = URL(string: backgroundUrlString)
        }
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            timestamp = formatter.date(from: timestampString)
        }
    }
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try!
                        JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser =  User(dictionary: dictionary)
                }
            }
            return _currentUser
            
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                //defaults.set(nil, forKey: "currentUserData")
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }}
