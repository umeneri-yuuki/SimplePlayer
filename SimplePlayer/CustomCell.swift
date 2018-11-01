//
//  CustomCell.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit
import MediaPlayer

class CustomCell: UITableViewCell {

    @IBOutlet weak var PlayListImage: UIImageView!
    @IBOutlet weak var StateButton: UIImageView!
    
    var player: MPMusicPlayerController!
    
    var playlistID = ""
    var sellID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sellID = NSUUID().uuidString
         player = MPMusicPlayerController.applicationQueuePlayer
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(type(of: self).nowPlayingStateChanged(notification:)), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: player)
        notificationCenter.addObserver(self,selector: #selector(type(of: self).nowPlayingStateChanged(notification:)),name:NSNotification.Name.UIApplicationDidBecomeActive,object: nil)
        // 通知の有効化
        player.beginGeneratingPlaybackNotifications()
        
        print("もんげーばなな")

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
        VC.startstop(ID: playlistID,sellID:sellID)
        
 
    }
    
    @IBAction func nextsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        VC.nextsong(ID: playlistID,sellID:sellID)
    }
    
    @IBAction func backsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        VC.backsong(ID: playlistID,sellID:sellID)
    }
    
    @objc func nowPlayingStateChanged(notification: NSNotification) {
        let VC = ((superview as! UITableView).delegate as! ViewController)
        if(VC.nowsellID == sellID){
            let playStatus = player.playbackState
            let layer:CALayer = StateButton.layer
            if (playStatus == .playing) {
                StateButton.image = UIImage(named: "Play")?.withRenderingMode(.alwaysTemplate)
                StateButton.tintColor = UIColor.white
                //画像を回転させる
                //let layer:CALayer = StateButton.layer
                let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
                animation.toValue = .pi / 2.0
                animation.duration = 1.5           // 0.5秒で90度回転
                animation.repeatCount = MAXFLOAT;   // 無限に繰り返す
                animation.isCumulative = true;         // 効果を累積
                layer.add(animation, forKey: "ImageViewRotation")
                
            }else if (playStatus == .paused){
                StateButton.image = UIImage(named: "Stop")?.withRenderingMode(.alwaysTemplate)
                StateButton.tintColor = UIColor.white
                layer.removeAllAnimations()
            }
        }else{
            StateButton.image = nil
        }
        
        
    }
    

    
    
    
    
}
