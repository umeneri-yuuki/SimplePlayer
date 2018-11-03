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
    
    
    //var myplaylist :(ID: String,thumbnail: Int,thumbnailcolor: UIColor?,thumbnailpicture: UIImage?)!
    var playlistpicture :UIImage!
    var playlistcolor :UIColor!
    var thumbnail = 0
    
    var player: MPMusicPlayerController!
    
    var playlistID = ""
    var sellID = ""
    var editmode = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        
       // self.sellID = NSUUID().uuidString
         player = MPMusicPlayerController.applicationQueuePlayer
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(type(of: self).nowPlayingStateChanged(notification:)), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: player)
        notificationCenter.addObserver(self,selector: #selector(type(of: self).nowPlayingStateChanged(notification:)),name:NSNotification.Name.UIApplicationDidBecomeActive,object: nil)
        notificationCenter.addObserver(self,selector: #selector(type(of: self).nowPlayingStateChanged(notification:)),name:NSNotification.Name.myNotificationName,object: nil)
        
        notificationCenter.addObserver(self,selector: #selector(type(of: self).editmodeChanged(notification:)),name:NSNotification.Name.editNof,object: nil)

       // notificationCenter.addObserver(self,selector: #selector(type(of: self).stateriset(notification:)),name:NSNotification.Name.stateriset,object: nil)
        // 通知の有効化
        player.beginGeneratingPlaybackNotifications()
        
       let playStatus = player.playbackState
           let layer:CALayer = StateButton.layer
        if (playStatus == .playing) {
            //let layer:CALayer = StateButton.layer
            
             let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
             animation.toValue = .pi / 2.0
             animation.duration = 1.5           // 0.5秒で90度回転
             animation.repeatCount = MAXFLOAT;   // 無限に繰り返す
             animation.isCumulative = true;         // 効果を累積
             layer.add(animation, forKey: "ImageViewRotation")
            
            
        }else if (playStatus == .paused){
             layer.removeAllAnimations()
        }
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.PlayListImage.image = nil
    }
    
    func cellimage(image:UIImage){
        self.PlayListImage.image = image
        
    }
    
    func cellcolor(color:UIColor){
        let size = self.PlayListImage.frame.size
        let image = UIImage.colorImage(color: color, size: size)
        self.PlayListImage.image = image
    }
    
    @IBAction func startstop(_ sender: Any) {
        let VC = ((superview as! UITableView).delegate as! ViewController)
        if(VC.editmode2 == false){
        VC.startstop(ID: playlistID,sellID:sellID)
        }
        
 
    }
    
    @IBAction func nextsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        if(VC.editmode2 == false){
        VC.nextsong(ID: playlistID,sellID:sellID)
        }
    }
    
    @IBAction func backsong(_ sender: Any) {

        let VC = ((superview as! UITableView).delegate as! ViewController)
        if(VC.editmode2 == false){
        VC.backsong(ID: playlistID,sellID:sellID)
        }
    }
    
    @objc func nowPlayingStateChanged(notification: NSNotification) {
        if(thumbnail == 0){
            let size = self.PlayListImage.frame.size
            let image = UIImage.colorImage(color: playlistcolor, size: size)
            self.PlayListImage.image = image
            
        }else{
            self.PlayListImage.image = playlistpicture
        }
        let VC = ((superview as! UITableView).delegate as! ViewController)

        if(VC.nowsellID == sellID && VC.editmode2 == false){
            let playStatus = player.playbackState
            let layer:CALayer = StateButton.layer
            if (playStatus == .playing) {
                StateButton.image = UIImage(named: "Play")?.withRenderingMode(.alwaysTemplate)
                StateButton.tintColor = UIColor.white
                //画像を回転させる
                //let layer:CALayer = StateButton.layer
                
                let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
                animation.toValue = .pi / 2.0
                animation.duration = 1.5           // 1.5秒で90度回転
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
    
    
    @objc func editmodeChanged(notification: NSNotification) {
        
        let VC = ((superview as! UITableView).delegate as! ViewController)
        
        
        self.frame.size.height = VC.TableView.rowHeight
        

        
    }

    @objc func stateriset(notification: NSNotification) {
        
         StateButton.image = nil
        
    }
    
    
    
}

extension UIImage {
    class func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(origin: .zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
