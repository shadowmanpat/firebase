//
//  UserCell.swift
//  breakpoint
//
//  Created by macbook on 26/08/2018.
//  Copyright © 2018 Nickagas. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profleIamge: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var showing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            checkImage.isHidden = false
            showing = true
        } else {
            checkImage.isHidden = true
            showing = false
        }
        // Configure the view for the selected state
    }
    
    func configureCell(profileIemge image: UIImage, email: String,isSelected: Bool){
        self.profleIamge.image = image
        self.emailLbl.text = email
        if isSelected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }


}
