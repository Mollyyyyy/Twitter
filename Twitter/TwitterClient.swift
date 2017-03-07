//
//  TwitterClient.swift
//  Twitter
//
//  Created by Apple on 2/27/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com/")!, consumerKey: "Ufh73prr2cjucbt0SDL72was7", consumerSecret: "IzpifpuEgzZJqQJCtKNl0uV3CX3mvWRW0Py38lv1yySryTOKF2")
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) in
            self.loginSuccess?()
        },failure: {(error:(Error?)!) in
            print("error: \(error??.localizedDescription)")
            self.loginFailure?(error!!)
        })
    
    }
    
    func login(success: @escaping ()->(),failure:@escaping (Error)->()){
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemoMolly://oauth")!, scope: nil, success: {
            (requestToken: BDBOAuth1Credential?) -> Void in
            //print("I got a token!")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.openURL(url)
            
            
        }, failure: {(error: Error?) -> Void in
            print("Error: \(error!.localizedDescription)")
            self.loginFailure!(error!)
        })
    
    }
    func logOut() {
        User.currentUser = nil
        deauthorize()        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    func currentAccount(){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success:
            {(task: URLSessionDataTask, response: Any?) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                print("name:\(user.name)")
                print("screenname:\(user.screenname)")
                print("profile url:\(user.profileUrl)")
                print("description:\(user.tagline)")
                
        },failure: {(task: URLSessionDataTask?, error: Error) in print("error!")})
    }
    
    func homeTimeline(success:  @escaping ([Tweet]) -> (), failure: @escaping
        (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any? ) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            failure(error!)
        })
    }
    
    func retweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/statuses/retweet.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }    }
    func unretweet(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/statuses/unretweet.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    func like(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }

    }
    func unlike(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    func postTweet(success: @escaping () -> (), failure: @escaping (Error) -> (), status: String) {
        post("1.1/statuses/update.json", parameters: ["status": status], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("posted tweet!! \(status)")
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }

    
}
