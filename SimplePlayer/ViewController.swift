//
//  ViewController.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/23.
//  Copyright © 2018年 村中　勇輝. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var player: MPMusicPlayerController!

    @IBOutlet weak var TableView: UITableView!
    
    var myplaylist: [(ID: String,thumbnail: Int,thumbnailcolor: UIColor?,thumbnailpicture: UIImage?)] = []
    
    var nowplaylist = ""
    
    let sectionnum = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.TableView.backgroundColor = UIColor.clear
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "mycell")
        
        player = MPMusicPlayerController.systemMusicPlayer
        
        player.repeatMode = .all
        player.shuffleMode = .songs
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.TableView.reloadData()
        print(myplaylist)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return myplaylist.count + 1
    }
    
    
    //セクションの背景を透明に
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
       
        headerView.backgroundColor = UIColor.clear
 
        return headerView
    }
 
    
    //セクションの高さを変える
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == myplaylist.count + 1){
            return 70
        }else{
            return 4
        }

    }
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == myplaylist.count + 1){
                return 0
        }else{
                return 1
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == myplaylist.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "addcell", for: indexPath)
            cell.contentView.backgroundColor = UIColor.clear
            return cell
        }else{
         let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCell
            cell.playlistID = myplaylist[indexPath.section].ID
            if(myplaylist.count != 0){
                if(myplaylist[indexPath.section].thumbnail==0){
                    cell.contentView.backgroundColor = myplaylist[indexPath.section].thumbnailcolor
                }else{
                    cell.cellimage(image: myplaylist[indexPath.section].thumbnailpicture!)
                }
            }
         return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == myplaylist.count){
            
            return 50
        }else{
            
            return 150
        }
        
    }

    @IBAction func NewPlaylist(_ sender: Any) {
        self.performSegue(withIdentifier: "toSelectThumbnail", sender: self)
    }
    
    func setPlaylist(ID: String) -> Bool{
        
        if(ID != nowplaylist){
            
            player.stop()
            
            nowplaylist = ID
        
            let query = MPMediaQuery.playlists()
            query.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))
            

            if let playlists = query.collections {
                
                for (_,item) in playlists.enumerated() {
                    let thisplaylist = item as! MPMediaPlaylist
                    if(String(thisplaylist.persistentID) == ID){
                    let playlistitemcollection = MPMediaItemCollection(items: thisplaylist.items)
                        player.setQueue(with: playlistitemcollection)
                    }
                }
                
            }
            return false
        }else{
            return true
        }
        
    }
    
    func startstop(ID: String){
        
        print("start:\(ID)")
        
        if(setPlaylist(ID: ID) == true){
            let playStatus = player.playbackState
            if (playStatus == .playing) {
                player.pause()
            }else if (playStatus == .paused){
                player.play()
            }
        }else{
            player.play()
        }
    }
    
    func nextsong(ID: String){
         print("next:\(ID)")
        
        if(setPlaylist(ID: ID) == true){
            player.skipToNextItem()
        }else{
            player.play()
        }
    }
    
    func backsong(ID: String){
         print("back:\(ID)")
        
        if(setPlaylist(ID: ID) == true){
            player.skipToPreviousItem()
        }else{
            player.play()
        }
    }
    
    

}

