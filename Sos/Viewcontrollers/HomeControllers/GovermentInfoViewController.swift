//
//  GovermentInfoViewController.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit

class GovermentInfoViewController: UIViewController {

    lazy var application = UIApplication.shared
    
    @IBOutlet var buttonss: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewCornerRadius(with: view)
        view.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
        
        buttonss[0].addTarget(self, action: #selector(call911), for: .touchUpInside)
        buttonss[1].addTarget(self, action: #selector(call199), for: .touchUpInside)
    }
    
    @objc func call911(){
        if let phoneUrl = URL(string: "tel://911"){
            if application.canOpenURL(phoneUrl) {
                application.open(phoneUrl, options: [:])
            }else{
                
                print("not valid phone call")
            }
        }
    }
    
    @objc func call199(){
        if let phoneUrl = URL(string: "tel://911"){
            if application.canOpenURL(phoneUrl) {
                application.open(phoneUrl, options: [:])
            }else{
                
                print("not valid phone call")
            }
        }
    }
}
