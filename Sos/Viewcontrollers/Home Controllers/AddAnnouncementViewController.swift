//
//  AddAnnouncementViewController.swift
//  Sos
//
//  Created by hussein awaesha on 12/23/20.
//

import UIKit
import FirebaseDatabase

class AddAnnouncementViewController: UIViewController {

    
    @IBOutlet weak var AnnouncementTitle: UITextField!
    
    @IBOutlet weak var AnnouncementBody: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database(url: "https://sosapp-7a8db-default-rtdb.firebaseio.com/").reference(/*withPath: "sosapp-7a8db-default-rtdb"*/).child("User")
    }
    
    @IBAction func uploadAnnouncement(_ sender: Any) {
        if !AnnouncementTitle.text!.isEmpty && !AnnouncementBody.text!.isEmpty{
            
            ref.child(AnnouncementTitle.text!).setValue(/*["announcement" : self.*/AnnouncementBody.text!/*]*/){
                (error,reference) in
                
                if let error = error{
                    print("Error uploading data to firebase \(error)")
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
