
//
//  LoginViewController.swift
//  Twitter
//
//  Created by Apple on 2/21/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string:"api.twitter.com")! ,consumerKey:"Ufh73prr2cjucbt0SDL72was7",consumerSecret:"IzpifpuEgzZJqQJCtKNl0uV3CX3mvWRW0Py38lv1yySryTOKF2")
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"twitterdemoMolly://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?)-> Void in
        print ("got a token")
            let url = URL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token)")!
            UIApplication.shared.openURL(url)
    }) {(error: Error?)->Void in
    print ("error:\(error?.localizedDescription)")
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
