//
//  PostTableViewCell.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
