//
//  ViewController.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/23.
//  Copyright © 2018年 村中　勇輝. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var TableView: UITableView!
    
    let sectionnum = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.TableView.backgroundColor = UIColor.clear
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "mycell")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionnum
    }
    
    
    //セクションの背景を透明に
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
       
        headerView.backgroundColor = UIColor.clear
 
        return headerView
    }
 
    
    //セクションの高さを変える
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == sectionnum-1){
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
        if(section == sectionnum-1){
                return 0
        }else{
                return 1
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCell
           cell.cellimage()

            cell.contentView.backgroundColor = UIColor.yellow
        

        
        return cell
    }



}

