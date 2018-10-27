
import UIKit
import MediaPlayer

class SelectPlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var TableView: UITableView!
    
    var playlist: [(name: String, ID: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        let query = MPMediaQuery.playlists()
        query.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))
        
  
        // 取得したアルバム情報を表示
        
        if let playlists = query.collections {
            
            for (_,item) in playlists.enumerated() {
                let thisplaylist = item as! MPMediaPlaylist
                playlist.append((thisplaylist.name!,String(thisplaylist.persistentID)))
            }
 
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistname", for: indexPath)
        cell.textLabel?.text = playlist[indexPath.row].name
        return cell
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {

            let nav = self.navigationController
            let STVC = nav?.viewControllers[(nav?.viewControllers.count)!-2] as! SelectThumbnailViewController
            STVC.selectplaylist = playlist[indexPath.row]
    
            self.navigationController?.popViewController(animated: true)
    }
    
    
}
