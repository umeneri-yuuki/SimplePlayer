//
//  CustomCell.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var PlayListImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellimage(){
        self.PlayListImage.image = UIImage(named: "黒子.JPG")
    }
    
    
    
}
