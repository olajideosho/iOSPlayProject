//
//  PostCarouselViewController.swift
//  CreativityTrial
//
//  Created by Olajide Osho on 03/07/2021.
//

import UIKit

class PostCarouselViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupPostView(_ post: PostDTO) {
        postImageView.image = UIImage(named: "postImage")
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        postDescriptionLabel.sizeToFit()
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.body
    }
}
