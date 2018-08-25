//
//  FeedCell.swift
//  breakpoint
//
//  Created by macbook on 25/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(profileImage: UIImage, email: String, content: String){
        self.imageProfile.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    }

}
