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
 
    var playlistID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellimage(image:UIImage){
        self.PlayListImage.image = image
    }
    
    @IBAction func startstop(_ sender: Any) {
   
        let VC = ((superview as! UITableView).delegate as! ViewController)
        VC.startstop(ID: playlistID)
    }
    
    @IBAction func nextsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        VC.nextsong(ID: playlistID)
    }
    
    @IBAction func backsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        VC.backsong(ID: playlistID)
    }
    
    
    
    
    
}
