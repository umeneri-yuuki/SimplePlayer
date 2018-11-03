//
//  SelectThumbnailViewController.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit

class SelectThumbnailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate{
    
    var selectplaylist = (name:"",ID:"")
    

    @IBOutlet weak var TableView: UITableView!
    
    var thispicture :UIScrollView!
    
    var selectimageindexpath: IndexPath!

    var selectmode = false
    
    var thumbnailpicture: UIImage? = UIImage(named:"noimage")
    
    var thumbnailcolor: UIColor!
    
    var thumbnail = 0
    
    var sellID = ""
    
    var selectrownum = -1
    
    var selectimageoffset = CGPoint(x: 0, y: 0)
    
    var selectimageoffsetheight = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        
        //ナビゲーションバーのボタンを作る
        let finishbutton :UIBarButtonItem = UIBarButtonItem(title:"完了", style: .plain, target: self, action: #selector(self.done))
        self.navigationItem.setRightBarButton(finishbutton, animated: true)
        
        let cancelbutton :UIBarButtonItem = UIBarButtonItem(title:"キャンセル", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.setLeftBarButton(cancelbutton, animated: true)
        
        if(thumbnail == 1 || selectmode == false){
        thumbnailcolor = UIColor.green
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.TableView.reloadData()
        
    }
    
    @objc func done(){
        
        //前画面に値を渡す
      // let nc = self.presentingViewController as!
        if(selectplaylist.ID == ""){
            
            let alertView = UIAlertController(title: "失敗しました", message: "プレイリストが設定されていません", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            
        }else if(thumbnail==1 && thumbnailpicture == nil){
            let alertView = UIAlertController(title: "失敗しました", message: "画像が設定されていません", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            
            
        }else{
            
            
           // let cell = TableView.dequeueReusableCell(withIdentifier: "selectcell", for: selectimageindexpath)
           // let thispicture = cell.viewWithTag(1) as! UIScrollView
            
            
           // let selectpicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 150))
           // selectpicture.image = thumbnailpicture
           // selectpicture.contentMode = .redraw
          //  selectpicture.
            
           // let resizewidth = thispicture.frame.width
           // let resizeimage = thumbnailpicture!.resized(toWidth: resizewidth)
            let selectpicture = thumbnailpicture?.resize(size: selectimageoffset)
            
            let nav = self.presentingViewController as! UINavigationController
            let VC = nav.topViewController  as! ViewController
            if(selectmode == false){
            VC.myplaylist.append((ID: selectplaylist.ID,name:selectplaylist.name,sellID: NSUUID().uuidString ,thumbnail: thumbnail,thumbnailcolor:thumbnailcolor,thumbnailpicture:selectpicture,fullsizepicture:thumbnailpicture,pictureoffsetheight: selectimageoffset.y))
            }else{
                VC.myplaylist[selectrownum] = (ID: selectplaylist.ID,name:selectplaylist.name,sellID: NSUUID().uuidString ,thumbnail: thumbnail,thumbnailcolor:thumbnailcolor,thumbnailpicture:selectpicture,fullsizepicture:thumbnailpicture,pictureoffsetheight: selectimageoffset.y)
            }
            
             self.dismiss(animated: true, completion: nil)
        }
 
      
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //サムネイル画像の選択ボタン
    @IBAction func selectpicture(_ sender: UIButton) {
        let picker: UIImagePickerController! = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //画像を選択したとき
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnailpicture = image
         }
        self.TableView.reloadData()
        
         selectimageoffset = CGPoint(x: 0, y: 0)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //画像の選択をキャンセルしたとき
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        self.dismiss(animated: true, completion: nil)
    }

    
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "プレイリストの設定"
        }else{
            return "サムネイルの設定"
        }
    }
    
    //セクションの背景を白に
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let label = UILabel()
        label.text = "プレイリストの設定"
        label.textColor = UIColor.black
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(label)
        return headerView
    }
 
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor.white
        return headerView
    }
 */
    

    
    // ひとつのセクションのとrowの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "playlistcell", for: indexPath)
            let playlisttext = cell.viewWithTag(1) as! UILabel
           
    
                if(selectplaylist.name == ""){
                    playlisttext.text = "選択されていません"
                }else{
                    playlisttext.text = selectplaylist.name
                }
  
            return cell
        }else{
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailselect", for: indexPath)
                let segmentbutton = cell.viewWithTag(1) as? UISegmentedControl
                segmentbutton?.selectedSegmentIndex = thumbnail
                
                return cell
            }else{
                if(thumbnail == 1){
                    //画像
                    let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell", for: indexPath)
                    selectimageindexpath = indexPath
                    
                    if let thumbnailpicture = thumbnailpicture {
                        thispicture = cell.viewWithTag(1) as? UIScrollView
                        thispicture.delegate = self
                        let resizewidth = thispicture.frame.width
                        let resizeimage = thumbnailpicture.resized(toWidth: resizewidth)
                        let selectimage = UIImageView(image: resizeimage)
                        
                        selectimage.contentMode = UIViewContentMode.scaleAspectFill
                        if(selectimageoffsetheight > -1){
                        selectimageoffset.y = selectimageoffsetheight
                        selectimageoffsetheight = CGFloat(-10)
                        }
                        thispicture.contentOffset = selectimageoffset
                        thispicture.addSubview(selectimage)
                        thispicture.contentSize = selectimage.frame.size
                        cell.contentView.addSubview(thispicture)
                    }
                    
                    return cell
                }else{
                    //色
                    let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell2", for: indexPath)
                    
                    let ColorSelectView2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
                    ColorSelectView2.layer.position = CGPoint(x: cell.contentView.frame.width/2, y:cell.contentView.frame.height/2)
                    
                    let view = HRColorPickerView(frame: ColorSelectView2.bounds)
                    view.color = thumbnailcolor
                    view.addTarget(self,
                                   action: #selector(self.colorChanged(sender:)),
                                   for: .valueChanged)
                    // self.contentView.addSubview(view)
                    ColorSelectView2.addSubview(view)
                    cell.contentView.addSubview(ColorSelectView2)
                     return cell
                }
            }
        }
      
    }
    
    @objc func imageChaged(sende: UIScrollView){
        
    }
    
    @objc func colorChanged(sender: HRColorPickerView) {
        // 色が変更された時に来る
        thumbnailcolor = sender.color
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if(indexPath.row == 0){
                
                return 80
            }else{
                
                return 500
            }
 
    }
    
    
    @IBAction func segmentButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            thumbnail = 0
             self.TableView.reloadData()
        case 1:
            thumbnail = 1
             self.TableView.reloadData()
        default:
            print("")
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        selectimageoffset = scrollView.contentOffset
    }
    
    
}

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let resizedSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    func resize(size offset: CGPoint) -> UIImage? {
        let width:CGFloat = 375
        let resizedSize = CGSize(width: 375, height: 150)
        let contentSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        let thisoffset = CGPoint(x: (offset.x)*15/14, y: -(offset.y)*15/14)
        draw(in: CGRect(origin: thisoffset, size: contentSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

