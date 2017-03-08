
//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Apple on 3/6/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
    @IBOutlet weak var followerscountlabel: UILabel!
    @IBOutlet weak var followingcountlabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var backgroungImageView: UIImageView!
    @IBOutlet weak var tweetscountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.setImageWith(user.profileUrl!)
        backgroungImageView.setImageWith(user.backgroundUrl!)
        nameLabel.text = user.name
        screennameLabel.text = "@ \(user.screenname!)"
        tweetscountLabel.text = user.tweetsNum
        followingcountlabel.text = user.followingNum
        followerscountlabel.text = user.followersNum
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        composeButton.setImage(UIImage(named: "Edit"), for: .normal)
    }

    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        if(segue.identifier == "EditSegue"){
            let EditVc = segue.destination as! EditViewController
            EditVc.user = self.user
        }
    }
    

}
