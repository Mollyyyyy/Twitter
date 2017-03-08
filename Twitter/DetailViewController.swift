//
//  DetailViewController.swift
//  Twitter
//
//  Created by Apple on 3/6/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var tweet: Tweet!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!    
    @IBOutlet weak var likecountLabel: UILabel!
    @IBOutlet weak var retweetcountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.name!
        screennameLabel.text = "@+\(tweet.screenname!)"
        contentLabel.text = tweet.text as String?
        photoImageView.setImageWith(tweet.profileUrl!)
        if let retweet = tweet?.retweetcount{
            retweetcountLabel.text =  String(retweet)}
        if let like = tweet?.likecount{
            likecountLabel.text =  String(like)}
        if(tweet.liked == false){
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
        }
        else{
            likeButton.setImage(UIImage(named: "LikeAfter"), for: .normal)
        }
        if(tweet.retweeted == false){
            retweetButton.setImage(UIImage(named: "Retweet"), for: .normal)
        }
        else{
            retweetButton.setImage(UIImage(named: "RetweetAfter"), for: .normal)
        }
        if let time = tweet?.timestamp{
            timestampLabel.text = String(describing: time)}
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onRetweet(_ sender: Any) {
        if(self.tweet.retweeted == false){
            TwitterClient.sharedInstance?.retweet(id: (tweet?.id)!, success: {
                self.tweet.retweeted = true
                self.tweet.retweetcount = self.tweet.retweetcount! + 1
                if let retweet = self.tweet?.retweetcount{
                    self.retweetcountLabel.text =  String(retweet)}
                self.retweetButton.setImage(UIImage(named: "RetweetAfter"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })}
        else{
            TwitterClient.sharedInstance?.unretweet(id: (tweet?.id)!, success: {
                self.tweet.retweeted = false
                self.tweet.retweetcount = self.tweet.retweetcount! - 1
                if let retweet = self.tweet?.retweetcount{
                    self.retweetcountLabel.text =  String(retweet)}
                self.retweetButton.setImage(UIImage(named: "Retweet"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })}

    }
   
    @IBAction func onLike(_ sender: Any) {
        if(self.tweet.liked == false){
            TwitterClient.sharedInstance!.like(id: (tweet?.id)!, success: {
                self.tweet.liked = true
                self.tweet.likecount = self.tweet.likecount! + 1
                if let like = self.tweet?.likecount{
                    self.likecountLabel.text =  String(like)}
                self.likeButton.setImage(UIImage(named: "LikeAfter"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })}
        else{
            TwitterClient.sharedInstance!.unlike(id: (tweet?.id)!, success: {
                self.tweet.liked = false
                self.tweet.likecount = self.tweet.likecount! - 1
                if let like = self.tweet?.likecount{
                    self.likecountLabel.text =  String(like)}
                self.likeButton.setImage(UIImage(named: "Like"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })}

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
 
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "Edit"){
            let EditVc = segue.destination as! EditViewController
            EditVc.user = tweet.user
            EditVc.replyName =  "@\(tweet.user.screenname!)"
        }
     
    }
    

}
