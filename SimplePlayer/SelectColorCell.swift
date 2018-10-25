//
//  SelectColorCell.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit

class SelectColorCell: UITableViewCell {

  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view = HRColorPickerView(frame: self.contentView.bounds)
        view.color = UIColor.green
        view.addTarget(self,
                       action: #selector(self.colorChanged(sender:)),
                       for: .valueChanged)
       // self.contentView.addSubview(view)
        self.contentView.addSubview(view)
    }
    
    @objc func colorChanged(sender: HRColorPickerView) {
        // 色が変更された時に来る
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
