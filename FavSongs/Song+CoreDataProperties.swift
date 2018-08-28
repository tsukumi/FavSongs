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

import Foundation
import CoreData

//Song Managed Object Properties
extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var artist: String?
    @NSManaged public var image: NSData?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var year: Int16

}
