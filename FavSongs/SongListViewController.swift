/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Assignment 2
 Author: Hao, Nguyen Xuan
 ID: 3639036
 Created date: 8/18/18
 Acknowledgements:
     K.Lee, Tutorial Contacts App iOS Swift 3 with CoreData
     Lynda Learning Resources
     Stanford CS193P Course
 */

import UIKit
import CoreData

class SongListViewController: UITableViewController {
    
    var songList: [Song] = []
    
    @IBOutlet var favList: UITableView!
    
    //Loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
        do {
            let song = try PersistentService.context.fetch(fetchRequest)
            self.songList = song
            self.favList.reloadData()
        } catch let error as NSError {
            print("Couldn't Fetch. \(error)")
        }
        self.favList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //To update a song
    func update(indexPath: IndexPath, title: String, artist: String, year: Int16, url: String, image: NSData) {
        let context = PersistentService.context
        let song = songList[indexPath.row]
        song.setValue(artist, forKey: "artist")
        song.setValue(title, forKey: "title")
        song.setValue(image, forKey: "image")
        song.setValue(year, forKey: "year")
        song.setValue(url, forKey: "url")
        do {
            try context.save()
            songList[indexPath.row] = song
        } catch let error as NSError {
            print("Couldn't Save. \(error)")
        }
    }
    //To save a song
    func save(title: String, artist: String, year: Int16, url: String, image: NSData) {
        let context = PersistentService.context
        let song = Song(context: context)
        song.setValue(artist, forKey: "artist")
        song.setValue(title, forKey: "title")
        song.setValue(image, forKey: "image")
        song.setValue(year, forKey: "year")
        song.setValue(url, forKey: "url")
        
        do {
            try context.save()
            self.songList.append(song)
        } catch let error as NSError {
            print("Couldn't Save. \(error)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath)
        let song = songList[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cell.imageView?.image = UIImage(data: (song.image)! as Data, scale: 1.0)
        
        return cell
    }
    
    //MARK: - Navigation
    @IBAction func unwindToSongList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? AddSongViewController {
            let title = viewController.titleTextField.text
            let artist = viewController.artistTextField.text
            let year = Int16(viewController.yearTextField.text!)!
            let url = viewController.urlTextField.text
            let image: NSData = UIImagePNGRepresentation(viewController.imageChoose.image!)! as NSData
            
            if  let indexPath = viewController.indexPathForSong {
                update(indexPath: indexPath, title: title!, artist: artist!, year: year, url: url!, image: image)
            } else {
                save(title: title!, artist: artist!, year: year, url: url!, image: image)
            }
            
            self.favList.reloadData()
        } else if let viewController = segue.source as? SongDetailsViewController {
            if (viewController.isDeleted == true) {
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let song = songList[indexPath.row]
                PersistentService.context.delete(song)
                self.songList.remove(at: indexPath.row)
                self.favList.deleteRows(at: [indexPath], with: .fade)
                PersistentService.saveContext()
                self.favList.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songDetailsSegue" {
            guard let viewController = segue.destination as? SongDetailsViewController else {return}
            guard let indexPath: IndexPath = favList.indexPathForSelectedRow else {return}
            let song = songList[indexPath.row]
            viewController.song = song
            viewController.indexPath = indexPath
        }
    }
}
