//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Ziyi Zhang on 8/11/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var messageBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
