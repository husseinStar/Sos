//
//  LogInViewController.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit
import FirebaseAuth
//MARK:- View
class LogInViewController: UIViewController {
    
    @IBOutlet weak var adminBtn: UIButton!
    
    @IBOutlet weak var userBtn: UIButton!
    
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBOutlet weak var register_button: UIButton!
    
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var showpasswordBtn: UIButton!
    var _showPass=false
    
    lazy var stndr = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setViewDesign()
    }
    
    @IBAction func adminBtn(_ sender: Any) {
        phoneTxt.placeholder = "admin_phone"
        passwordTxt.placeholder = "otp"
        register_button.setTitle("admin_register", for: .normal)
    }
    
    @IBAction func userBtn(_ sender: Any) {
        phoneTxt.placeholder = "auser_phone"
        passwordTxt.placeholder = "otp"
        register_button.setTitle("user_register", for: .normal)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
       
        //1-verifyPhoneNumber 2-credential 3-signIn
        
        var id = String()
        //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneTxt.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error{
                debugPrint("Error: \(error.localizedDescription)")
            }else{
                id = verificationID!
                print("the id is is \(id)")
            }
        }
        if !id.isEmpty{
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: id, verificationCode: passwordTxt.text!)
        Auth.auth().signIn(with: credential) { (data, error) in
            if let error = error{
                debugPrint("error: \(error.localizedDescription)")
            }else{
                print("ther's no verificationID")
            }
          }
        }
        let main = UIStoryboard(name: "Main", bundle: nil)
        let tab_bar = main.instantiateViewController(identifier: "mainTab")
        UIApplication.shared.keyWindow?.rootViewController = tab_bar
    }
    
    @IBAction func showPass(_ sender: Any) {
        if _showPass{
            passwordTxt.isSecureTextEntry=false
            showpasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }else{
            showpasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTxt.isSecureTextEntry=true
        }
        _showPass = !_showPass
        
    }
    
}

//MARK:- Controllers
extension LogInViewController{
    
    func setViewDesign(){
        buttonCornerRadius(with: adminBtn)
        buttonCornerRadius(with: userBtn)
        buttonCornerRadius(with: enterBtn)
    }
}
//MARK:- FIR hit
extension LogInViewController{
    
}
