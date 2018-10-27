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
       // self.contentView.addSubview(ColorSelectView)
       // let view = HRColorPickerView(frame: self.contentView.bounds)
        /*
        let ColorSelectView2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        ColorSelectView2.layer.position = CGPoint(x: self.contentView.frame.width/2, y: self.contentView.frame.height/2)
      

        let view = HRColorPickerView(frame: ColorSelectView2.bounds)
        view.color = UIColor.green
        view.addTarget(self,
                       action: #selector(self.colorChanged(sender:)),
                       for: .valueChanged)
       // self.contentView.addSubview(view)
        ColorSelectView2.addSubview(view)
        self.contentView.addSubview(ColorSelectView2)
 */
    }
    /*
    @objc func colorChanged(sender: HRColorPickerView) {
        // 色が変更された時に来る
    }
 */

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
