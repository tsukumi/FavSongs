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

class AddSongViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var header = "Add New Song"
    var song: Song? = nil
    var indexPathForSong: IndexPath? = nil //Index of song currently in views -- in this case, songs in edit

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = header
        yearTextField.keyboardType = .numberPad //Set default keyboard type for year
        
        //Load chosen song from details view
        if let song = self.song {
            titleTextField.text = song.title
            artistTextField.text = song.artist
            yearTextField.text = "\(song.year)"
            urlTextField.text = song.url
            imageChoose.image = UIImage(data: (song.image)! as Data, scale: 1.0)
        }
    }
        // Do any additional setup after loading the view.

    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var artistTextField: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var imageChoose: UIImageView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Add a new song
    @IBAction func addNewSong(_ sender: UIBarButtonItem) {
        if !(titleTextField.text == "" || artistTextField.text == "" || yearTextField.text == "" || imageChoose.image == nil){
        performSegue(withIdentifier: "unwindToSongList", sender: self)
        }
    }
    
    //Choose image from library
    @IBAction func chooseImage(_ sender: UIButton) {
        let imageView = UIImagePickerController()
        imageView.delegate = self
        imageView.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imageView.allowsEditing = false
        self.present(imageView, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageView = info[UIImagePickerControllerOriginalImage] as? UIImage
        { imageChoose.image = imageView } else { }
        
        self.dismiss(animated: true, completion: nil)
    }   

}
