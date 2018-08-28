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

class SongDetailsViewController: UIViewController {
    
    var song: Song? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil //index of song currently in view -- needed for passing through views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load Details for Songs
        titleLabel.text = song?.title
        artistLabel.text = song?.artist
        yearLabel.text = "\(song?.year ?? 0)"
        imageDetails.image = UIImage(data: (song?.image)! as Data, scale: 1.0)    
    }

    @IBOutlet weak var imageDetails: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    //URL interactions 1: Normal tappable button
    @IBAction func URLbutton(_ sender: UIButton) {
        UIApplication.shared.open(NSURL(string: (song?.url)!)! as URL, options: [:], completionHandler: nil)
    }
    
    //URL interactions 2: Tappable image
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: (song?.url)!)! as URL, options: [:], completionHandler: nil)
    }
    
    //To delete a song
    @IBAction func deleteSong(_ sender: UIButton) {
        //Alert popup settings
        let alert = UIAlertController(title: "Are you sure you want to delete this song?", message: "This action is irreversible, please reconsider before continue", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            self.isDeleted = true
            self.performSegue(withIdentifier: "unwindToSongList", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in})
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSongSegue" {
            guard let viewController = segue.destination as? AddSongViewController else {return}
            viewController.header = "Edit Song"
            viewController.song = song
            viewController.indexPathForSong = self.indexPath!            
        }
    }
   
    
}
    


