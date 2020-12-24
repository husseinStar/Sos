//
//  HomeViewController.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseUI
import CoreLocation

class HomeViewController: UIViewController ,CLLocationManagerDelegate{
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    ///User View: Hold user data
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    
    //Map view : responsible of design
    @IBOutlet weak var mapVIew: UIView!
    
    @IBOutlet weak var govermentView: UIView!
    @IBOutlet weak var sosView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    var imagePickerController = UIImagePickerController()
    
    lazy var addAnnouncement = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        checkPermissions()
        setViewDesign()
    }
  
    
    @IBAction func GMSBtn(_ sender: Any) {
        
        func locationEnabled(){
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    debugPrint(" App have no Location permission")
                //show Alert no location permission
                case .authorizedAlways, .authorizedWhenInUse:
                    let vc = GMSViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    debugPrint("Access")
                @unknown default:
                    break
                }
            } else
            {//show Alert no Enable location
            }
            
        }
    }
    
    @IBAction func govermentBtn(_ sender: Any) {
        self.mainView.layer.opacity=0.4
        self.mainView.alpha=0.4
        self.topView.layer.opacity=0.4
        self.topView.alpha=0.4
        containerViewBottomConstraint.constant = -40
    }
    @IBAction func sosBtn(_ sender: Any) {
        performSegue(withIdentifier: "addAnnouncement", sender: sender)
    }
    
    @IBAction func changeImage(_ sender: Any) {
        presentPhotoActionSheet()
    }
    
}
//MARK:- Controllers
extension HomeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //UIGestureRecognizer if you want to animate anything
    //let hideContainer = UIGestureRecognizer(target: self, action: #selector(hideContainerView))
    //userView.addGestureRecognizer(hideContainer)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        if touch.view != containerView {
            self.mainView.layer.opacity=1
            self.mainView.alpha=1
            self.topView.layer.opacity=1
            self.topView.alpha=1
            containerViewBottomConstraint.constant = -500
        }
        
    }
    
    func setViewDesign(){
        viewsCornerRadius(with: mapVIew)
        viewsCornerRadius(with: userView)
        viewsCornerRadius(with: govermentView)
        viewsCornerRadius(with: sosView)
        viewCornerRadius(with: topView)
        viewCornerRadius(with: containerView)
        userImage.layer.cornerRadius = userImage.frame.height/2
        
    }
    
    @objc func hideContainerView(){
        if view != containerView {
            self.mainView.layer.opacity=1
            self.mainView.alpha=1
            self.topView.layer.opacity=1
            self.topView.alpha=1
            containerViewBottomConstraint.constant = -500
        }    }
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture" ,
                                            message: "How would you like to select a picture?" ,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel" ,
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo" ,
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentCamera()
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo" ,
                                            style: .default,
                                            handler: { [weak self] _ in
                                                
                                                self?.presentPhotoPicker()
                                                
                                            }))
        
        present(actionSheet, animated: true)
    }
    
    
    func presentCamera() {
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func presentPhotoPicker() {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthroizationHandler)
        }
    }
    
    func requestAuthroizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("We have access to photos")
        } else {
            print("We dont have access to photos")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
            uploadToCloud(fileURL: url)
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadToCloud(fileURL : URL) {
        let storage = Storage.storage()
                
        let storageRef = storage.reference()
        
        let localFile = fileURL
        
        let photoRef = storageRef.child("photo")
        
         let uploadTask = photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard let _ = metadata else {
                print(err!.localizedDescription)
                return
            }
            print("Photo Upload")
            
         }
        uploadTask.enqueue()
        
    }
    
}
//MARK:- FIR hit
extension HomeViewController{
    
}
