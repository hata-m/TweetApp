//
//  ViewController.swift
//  TweetApp
//
//  Created by PC220205 on 2022/09/01.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,TweetViewControllerDelegate {


    
    var tweets: [Tweet] = []
    @IBOutlet weak var tweetTableView: UITableView!
    @IBOutlet weak var tweetAddButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tweetTableView.reloadData()
        tweetTableView.estimatedRowHeight = 200
        tweetTableView.rowHeight = UITableView.automaticDimension
    }
    @IBAction func didTouchTweetButton(_ sender: Any) {
        performSegue(withIdentifier: "TweetViewSeque", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TweetViewSeque"{
            let viewController = segue.destination as! TweetViewController
//            viewController.massage = myTextField.text
            viewController.delegate = self
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets.count==0{
            return 1
        }else{
            return tweets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! MyTableViewCell
        if tweets.count == 0{
            cell.contributorLabel.text = ""
            cell.postTitle.text = "まだ投稿がありません"
            cell.postContent.text = ""
            cell.postContent.isEditable = false
            cell.imageView?.image = UIImage(systemName: "person.crop.circle.fill.badge.xmark")?.resized(size: CGSize(width: 55, height: 55))
        }else{
            let tweet = tweets[indexPath.row]
            cell.contributorLabel.text = "投稿者：\(tweet.name ?? "")"
            cell.postTitle.text = "タイトル：\(tweet.tweetTitle ?? "")"
            cell.postContent.text = "投稿内容\n\(tweet.content ?? "")"
            if tweet.uiImage != nil{
                cell.imageView?.image = tweet.uiImage
            }else{
                cell.imageView?.image = UIImage(systemName: "person.crop.circle.fill.badge.xmark")?.resized(size: CGSize(width: 55, height: 55))
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                if(!(tweets.count==0)){
                    tweets.remove(at: indexPath.row)
                }
                tweetTableView.reloadData()
            case .insert, .none:
                break
        @unknown default:
            print("unknown")
        }
    }
    
    func didFinishEditing(massage: Tweet!) {
        tweets.append(massage)
    }

}

class MyTableViewCell: UITableViewCell{
    
    @IBOutlet weak var contributorLabel: UILabel!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var postimage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
}
