//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Kimberly Zai on 6/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var likeBond: Bond<[PFUser]?>!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        likeBond = Bond<[PFUser]?>() { [unowned self] likeList in
            if let likeList = likeList {
                self.likesLabel.text = self.stringFromUserList(likeList)
                self.likeButton.selected = contains(likeList, PFUser.currentUser()!)
                self.likesIconImageView.hidden = (likeList.count == 0)
            } else {
                // if there is no list of users that like this post, reset everything
                self.likesLabel.text = ""
                self.likeButton.selected = false
                self.likesIconImageView.hidden = true
            }
        }
    }
    
    // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
    func stringFromUserList(userList: [PFUser]) -> String {
        let usernameList = userList.map { user in user.username! }
        let commaSeparatedUserList = ", ".join(usernameList)
        
        return commaSeparatedUserList
    }
    

    var post: Post? {
        didSet {
            // free memory of image stored with post that is no longer displayed
            if let oldValue = oldValue where oldValue != post {
                likeBond.unbindAll()
                postImageView.designatedBond.unbindAll()
                
                if (oldValue.image.bonds.count == 0) {
                    oldValue.image.value = nil
                }
            }
            
            
            if let post = post {
                //bind the image of the post to the 'postImage' view
                post.image ->> postImageView
                
                //bind the likeBond that we defined earlier, to update like lable and button when likes change
                post.likes ->> likeBond
            }
        }
    }
    
    
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
    
}

extension PFObject : Equatable {
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    return lhs.objectId == rhs.objectId
}

