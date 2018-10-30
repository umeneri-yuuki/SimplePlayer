//
//  SelectThumbnailViewController.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit

class SelectThumbnailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var selectplaylist = (name:"",ID:"")
    

    @IBOutlet weak var TableView: UITableView!
    
    
    var thumbnailpicture: UIImage? = UIImage(named:"noimage")
    
    var thumbnailcolor: UIColor!
    
    var thumbnail = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        //ナビゲーションバーのボタンを作る
        let finishbutton :UIBarButtonItem = UIBarButtonItem(title:"完了", style: .plain, target: self, action: #selector(self.done))
        self.navigationItem.setRightBarButton(finishbutton, animated: true)
        
        let cancelbutton :UIBarButtonItem = UIBarButtonItem(title:"キャンセル", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.setLeftBarButton(cancelbutton, animated: true)
        
        thumbnailcolor = UIColor.green
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.TableView.reloadData()
        
    }
    
    @objc func done(){
        
        //前画面に値を渡す
      // let nc = self.presentingViewController as!
        let VC = self.presentingViewController as! ViewController
        VC.myplaylist.append((ID: selectplaylist.ID,thumbnail: thumbnail,thumbnailcolor:thumbnailcolor,thumbnailpicture:thumbnailpicture))
        
         self.dismiss(animated: true, completion: nil)
 
      
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
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //画像の選択をきキャンセルしたとき
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
                
                return cell
            }else{
                if(thumbnail == 1){
                    //画像
                    let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell", for: indexPath)
                    let thispicture = cell.viewWithTag(1) as! UIImageView
                    thispicture.image = thumbnailpicture
                    return cell
                }else{
                    //色
                    let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell2", for: indexPath)
                    
                    let ColorSelectView2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
                    ColorSelectView2.layer.position = CGPoint(x: cell.contentView.frame.width/2, y:cell.contentView.frame.height/2)
                    
                    let view = HRColorPickerView(frame: ColorSelectView2.bounds)
                    view.color = UIColor.green
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
  

}
