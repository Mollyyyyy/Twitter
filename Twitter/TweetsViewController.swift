//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Apple on 2/27/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tweets:[Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self //assign the datasource
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text!)
                self.tableView.reloadData()
            }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logOut()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        }
        else {
            return 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
