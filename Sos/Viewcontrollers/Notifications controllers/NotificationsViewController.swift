//
//  NotificationsViewController.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit
import FirebaseDatabase
class NotificationsViewController: UIViewController, UITableViewDataSource {
    var dummyArr:[String]=[/*"1. إنهيار جبلي كبير على طريق جرش عجلون وإغلاق كامل للطريق.٢٠ مايو 2020 - 3:30 ص","2. إنهيار جبلي كبير على طريق جرش عجلون و \n إغلاق كامل للطريق.٢٠ مايو 2020 - 3:30 ص","١. إنهيار جبلي كبير على طريق جرش عجلون وإغلاق كامل للطريق.٢٠ مايو 2020 - 3:30 ص"*/]
    
    @IBOutlet weak var notificationsTableView: UITableView!
    
    var ref: DatabaseReference!
    var str: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //notificationsTableView.delegate=self//No actions on tableView
        notificationsTableView.dataSource=self
        
        ref = Database.database(url: "https://sosapp-7a8db-default-rtdb.firebaseio.com/").reference(/*withPath: "sosapp-7a8db-default-rtdb"*/).child("User")
        
        ref.child("announcement_title").observe(.value){
            (snapshot) in
            
            if let snapVal = snapshot.value as? String {
                
                self.dummyArr.append(snapVal)
                
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as! NotificationsTableViewCell
       
        cell.setLabel(title: dummyArr[indexPath.row])
        
        return cell
    }

}
