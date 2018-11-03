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
    
    let notificationCenter = NotificationCenter.default

    @IBOutlet weak var TableView: UITableView!

    
    var myplaylist: [(ID: String,name: String,sellID: String,thumbnail: Int,thumbnailcolor: UIColor?,thumbnailpicture: UIImage?,fullsizepicture: UIImage?,pictureoffsetheight: CGFloat)] = []
    
    var nowplaylist = ""

    var nowsellID = ""
    
    var editmode = false
    
    var editmode2 = false
    
    var editIndexPath :IndexPath!
    
    var editcellcount = 1
    
    var selectrownum = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
       // appDelegate.viewController = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let finishbutton :UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Finish"), style: .plain, target: self, action: #selector(self.editfinish))
        
        self.navigationItem.setRightBarButton(finishbutton, animated: true)
        
        
        self.view.backgroundColor = UIColor.black
        self.TableView.backgroundColor = UIColor.clear
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "mycell")
        
        player = MPMusicPlayerController.applicationQueuePlayer
        
    //    player = MPMusicPlayerController.systemMusicPlayer
        
        player.repeatMode = .all
        player.shuffleMode = .songs
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.black
         self.TableView.reloadData()
        print(myplaylist)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ナビゲーションバーをステータスバーに被るようにする
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {

            return 3
        
    }
    
    
    //セクションの背景を透明に
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
       
        headerView.backgroundColor = UIColor.clear
 
        return headerView
    }
 
    
    //セクションの高さを変える
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if(section == 2){
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

            if(section == 2){
                    return 0
            }else if(section == 1){
                    return editcellcount
            }else{
                    return myplaylist.count
            }
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if(indexPath.section == 1){

                    editIndexPath = indexPath
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addcell", for: indexPath)
                     let addbutton1 = cell.viewWithTag(1) as! UIButton
                    addbutton1.setImage(UIImage(named: "Add")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    addbutton1.imageView?.contentMode = .scaleAspectFit
                    addbutton1.tintColor = UIColor.white
                    let addbutton2 = cell.viewWithTag(2) as! UIButton
                    addbutton2.setImage(UIImage(named: "Edit")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    addbutton2.imageView?.contentMode = .scaleAspectFit
                    addbutton2.tintColor = UIColor.white
                    let addbutton3 = cell.viewWithTag(3) as! UIButton
                    addbutton3.setImage(UIImage(named: "Config")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    addbutton3.imageView?.contentMode = .scaleAspectFit
                    addbutton3.tintColor = UIColor.white
                    cell.contentView.backgroundColor = UIColor.clear
                    return cell
                
                
            }else{
                     let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCell
                        cell.selectionStyle = .none
                       // cell.myplaylist = myplaylist[indexPath.row]
                
                        cell.sellID = myplaylist[indexPath.row].sellID
                        cell.playlistID = myplaylist[indexPath.row].ID
                        cell.thumbnail = myplaylist[indexPath.row].thumbnail

                        if(myplaylist.count != 0){
                            if(myplaylist[indexPath.row].thumbnail==0){
                                //cell.PlayListImage.backgroundColor = myplaylist[indexPath.row].thumbnailcolor
                                
                                cell.cellcolor(color: myplaylist[indexPath.row].thumbnailcolor!)
                                
                                cell.playlistcolor = myplaylist[indexPath.row].thumbnailcolor
                            }else{
                                cell.cellimage(image: myplaylist[indexPath.row].thumbnailpicture!)
                                cell.playlistpicture = myplaylist[indexPath.row].thumbnailpicture
                            }
                        }
                     return cell
 

            }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            if(indexPath.section == 1){
                
                    return 50
                
            }else{
                
                if(editmode == true){
                        return 74
                }else{
                         return 154
                }
                
            }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        notificationCenter.post(name: .myNotificationName, object: nil)
    }
    
    
    //セルの削除
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if(editmode2 == true){
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            if(indexPath.section == 0){
            self.myplaylist.remove(at: indexPath.row)
            }else{
                self.editcellcount = 0
            }
            
            self.TableView.deleteRows(at: [indexPath], with: .fade)

        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
        }else{
            let selectButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "編集") { (action, index) -> Void in
                
            self.player.pause()
            self.selectrownum = indexPath.row
            self.performSegue(withIdentifier: "toEditPlaylist", sender: self)
                
            }
            /*
            selectButton.setImage(UIImage(named: "Right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            selectButton.imageView?.contentMode = .scaleAspectFit
            selectButton.tintColor = UIColor.white
             */
            
            selectButton.backgroundColor = UIColor.black
            //selectButton.backgroundColor = UIColor(patternImage: UIImage(named: "Right")!)
            
       
            return [selectButton]
        }
    }
    
    //セルの移動処理
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let playlist = self.myplaylist[sourceIndexPath.row]
        self.myplaylist.remove(at: sourceIndexPath.row)
        self.myplaylist.insert(playlist, at: destinationIndexPath.row)
        
    }
    
    /*
    func tableView(_ tableView: UITableView,editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .none
    }
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toEditPlaylist") {
            let nc = segue.destination as! UINavigationController
            let STVC = nc.topViewController as! SelectThumbnailViewController
            STVC.selectplaylist.ID = myplaylist[selectrownum].ID
            STVC.selectplaylist.name = myplaylist[selectrownum].name
            STVC.sellID = myplaylist[selectrownum].sellID
            STVC.thumbnail = myplaylist[selectrownum].thumbnail
            STVC.thumbnailcolor = myplaylist[selectrownum].thumbnailcolor
            STVC.thumbnailpicture = myplaylist[selectrownum].fullsizepicture
            STVC.selectimageoffsetheight = myplaylist[selectrownum].pictureoffsetheight
            STVC.selectmode = true
            STVC.selectrownum = selectrownum
 
        }
        if (segue.identifier == "toSelectThumbnail") {
            let nc = segue.destination as! UINavigationController
            let STVC = nc.topViewController as! SelectThumbnailViewController
            STVC.selectmode = false
            
        }
        
        
    }
    
    

    @IBAction func NewPlaylist(_ sender: Any) {
        self.performSegue(withIdentifier: "toSelectThumbnail", sender: self)
    }
   
    
    @IBAction func EditPlaylistlist(_ sender: UIButton) {
        
       // let cell = sender.superview?.superview as? UITableViewCell
      //  let indexPath = self.TableView.indexPath( for: cell! )
        
        
        if(editmode2 == false){
            navigationController?.setNavigationBarHidden(false, animated: true)
            editmode2 = true
        }else{
            navigationController?.setNavigationBarHidden(true, animated: true)
            editmode2 = false
        }
        
       // self.TableView.
        
        player.pause()
        if(editmode2 == true){
        notificationCenter.post(name: .myNotificationName, object: nil)
        }

        
        

        self.TableView.beginUpdates()
        
        self.TableView.setEditing(true, animated: true)
        
        self.editcellcount = 0
        self.TableView.deleteRows(at: [editIndexPath!], with: UITableViewRowAnimation.fade)
        
        if(editmode == false){
            notificationCenter.post(name: .editNof, object: nil)
            editmode = true
             self.TableView.endUpdates()
        }else{
            editmode = false
             self.TableView.endUpdates()
            notificationCenter.post(name: .editNof, object: nil)
        }
        
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // 0.5秒後に実行したい処理
            self.notificationCenter.post(name: .myNotificationName, object: nil)
        }

        
               
    }
    
    @objc func editfinish(){
        
         self.editcellcount = 1
        
        
        if(editmode2 == false){
            navigationController?.setNavigationBarHidden(false, animated: true)
            editmode2 = true
        }else{
            navigationController?.setNavigationBarHidden(true, animated: true)
            editmode2 = false
        }
        
        player.pause()
        if(editmode2 == true){
            notificationCenter.post(name: .myNotificationName, object: nil)
        }
        
        self.TableView.beginUpdates()

       self.TableView.setEditing(false, animated: true)
        
        self.TableView.insertRows(at: [editIndexPath!], with: .automatic)
        
        if(editmode == false){
            notificationCenter.post(name: .editNof, object: nil)
            editmode = true
            self.TableView.endUpdates()
        }else{
            editmode = false
            self.TableView.endUpdates()
            notificationCenter.post(name: .editNof, object: nil)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // 0.5秒後に実行したい処理
            self.notificationCenter.post(name: .myNotificationName, object: nil)
        }

    }

    
    func setPlaylist(ID: String,sellID: String) -> Bool{
        
        if(ID != nowplaylist || sellID != nowsellID){
            
            player.stop()
            
            nowplaylist = ID
            
            nowsellID = sellID
        
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
    
    func startstop(ID: String,sellID: String){

        
        print("start:\(ID) cellID:\(sellID)")
        
        
        if(setPlaylist(ID: ID ,sellID: sellID) == true){
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
    
    func nextsong(ID: String,sellID: String){
         print("next:\(ID) secNum:\(sellID)")
        
        
        if(setPlaylist(ID: ID, sellID: sellID) == true){
            player.skipToNextItem()
            player.play()
        }else{
            player.play()
        }
    }
    
    func backsong(ID: String,sellID: String){
         print("back:\(ID) secNum:\(sellID)")
        
        if(setPlaylist(ID: ID ,sellID: sellID) == true){
            player.skipToPreviousItem()
            player.play()
        }else{
            player.play()
        }
    }
    

    
    

}


extension Notification.Name {
    static let myNotificationName = Notification.Name("myNotificationName")
    static let editNof = Notification.Name("editNof")
   // static let stateriset = Notification.Name("statereset")
}





