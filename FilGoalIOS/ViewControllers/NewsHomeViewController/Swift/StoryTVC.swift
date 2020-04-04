//
//  StoryTVC.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit

class StoryTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var shadwoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var iconImgHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        shadwoView.backgroundColor = UIColor.white
    }

    func initWith(title: String , image: String) {
        titleLbl.text = title
        if image != "" {
            imgView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "place_holder.jpg"), completed: { image, error, cacheType, imageURL in
                self.activityIndicator.stopAnimating()
            })
        }
    }
    
}
