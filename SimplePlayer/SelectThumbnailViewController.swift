//
//  SelectThumbnailViewController.swift
//  SimplePlayer
//
//  Created by 村中　勇輝 on 2018/10/25.
//  Copyright © 2018 村中　勇輝. All rights reserved.
//

import UIKit

class SelectThumbnailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var TableView: UITableView!
    
    var thumbnail = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "SelectImageCell", bundle: nil), forCellReuseIdentifier: "selectcell")
        
        //  TableView.estimatedRowHeight = 80 //セルの高さ
        //  TableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailselect", for: indexPath)
            
            return cell
        }else{
            if(thumbnail == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell", for: indexPath) as! SelectImageCell
                 return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectcell2", for: indexPath) as! SelectColorCell
                 return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            
            return 80
        }else{
            
            return 300
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
