
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
    var tagline:String?
    static var _currentUser: User?
    var dictionary: NSDictionary?
    static let userDidLogOutNotification = "UserDidLogOut"
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlSting = dictionary["profile_image_url_https"] as? String
        if let profileUrlSting = profileUrlSting{
            profileUrl = URL(string: profileUrlSting)
        }
        tagline = dictionary["description"] as? String
    }
    
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.data(withJSONObject: userData, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
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
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
