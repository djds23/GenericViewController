//
//  PostViewController.swift
//  GenericViewControllerDemoApp
//
//  Created by Dean Silfen on 4/25/18.
//  Copyright © 2018 Dean Silfen. All rights reserved.
//

import UIKit
import GenericViewControllerKit

protocol PostViewControllerDelegate: class {
    func postViewController(postViewController: PostViewController, didToggleLikeFor post: Post)
}

class PostViewController: GenericViewController<Post> {
    weak var delegate: PostViewControllerDelegate?
    @IBOutlet weak var stackView: UIStackView!
    lazy var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    lazy var bodyLabel = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.bodyLabel)
        self.render()
    }
    
    override func render() {
        if let post = self.state {
            self.view.backgroundColor = post.liked ? UIColor.pink : UIColor.white
            self.titleLabel.text = post.title
            self.bodyLabel.text = post.body
        } else {
            self.titleLabel.text = "No Post"
            self.bodyLabel.text = ""
            self.view.backgroundColor = UIColor.white
        }
    }

    @IBAction func toggleLike(_ sender: Any) {
        if let post = self.state {
            self.delegate?.postViewController(postViewController: self, didToggleLikeFor: post)
        }
    }
}
