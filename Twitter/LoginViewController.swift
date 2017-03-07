
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "twitter")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   
    
        @IBAction func onLoginButton(_ sender: UIButton) {
            let twitterClient = TwitterClient.sharedInstance
            twitterClient?.login(success: {
                print("Logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            , failure: { (error: Error) in
                    print("Error: \(error.localizedDescription)")
            })
            
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
