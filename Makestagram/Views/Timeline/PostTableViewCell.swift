//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Kimberly Zai on 6/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!

    var post: Post? {
        didSet {
            if let post = post {
                //bind the image of the post to the 'postImage' view
                post.image ->> postImageView
            }
        }
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
    }
    
}
