//
//  EditViewController.swift
//  Twitter
//
//  Created by Apple on 3/6/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UITextViewDelegate {
    var user: User!
    var replyName : String?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var wordsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTextView.becomeFirstResponder()
        wordsTextView.delegate = self
        if let name = replyName{
            wordsTextView.text = name
        }
        photoImage.setImageWith(user.profileUrl!)
        nameLabel.text = user.name
        screennameLabel.text = "@ \(user.screenname!)"
    }
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        countLabel.text = String((140 - wordsTextView.text.characters.count)) //the textView parameter is the textView where text was changed
    }
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func onSend(_ sender: Any) {
        TwitterClient.sharedInstance?.postTweet(success: { () in
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        }, failure: { (error: Error) in
            print("error: \(error.localizedDescription)")
        }, status: wordsTextView.text!)
        
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
