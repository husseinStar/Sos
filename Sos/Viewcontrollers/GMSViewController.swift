//
//  GMSViewController.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
//Not used replaced with MapViewController
class GMSViewController: UIViewController {
    var locationManager = CLLocationManager()
    let geocoder = GMSGeocoder()
    var bounds = GMSCoordinateBounds()
    var sourceLat = 31.965065
    var sourceLong = 35.88362
    var address: String = "Amman, Jordan"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.delegate = self
        txtFieldSearch.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        setupViews()
        initGoogleMaps()
    }
    
    
    //I created an Auto Layout extension functions that's
    //used like:
    func setupViews() {
        view.addSubview(myMapView)
       /* this: myMapView.addConstraints(<#T##top: NSLayoutYAxisAnchor?##NSLayoutYAxisAnchor?#>, <#T##lead: NSLayoutXAxisAnchor?##NSLayoutXAxisAnchor?#>, <#T##bottom: NSLayoutYAxisAnchor?##NSLayoutYAxisAnchor?#>, <#T##trail: NSLayoutXAxisAnchor?##NSLayoutXAxisAnchor?#>, <#T##padding: UIEdgeInsets##UIEdgeInsets#>, <#T##size: CGSize##CGSize#>)*/
        /* and this: view.addviews([sub_view1,sub_view2])*/
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
        
        self.view.addSubview(backBtn)
        //if Statics.appLanguage=="ar"
        //{backBtn.rightAnchor.constraint(equalTo: myMapView.rightAnchor, constant: -15).isActive=true }
       // else{
            backBtn.leftAnchor.constraint(equalTo: myMapView.leftAnchor, constant: 15).isActive=true// }
        backBtn.topAnchor.constraint(equalTo: myMapView.topAnchor, constant: 40).isActive=true
        backBtn.heightAnchor.constraint(equalToConstant: 40).isActive=true
        backBtn.widthAnchor.constraint(equalTo: backBtn.heightAnchor).isActive=true
       
        self.view.addSubview(txtFieldSearch)
//        if Statics.appLanguage=="ar"{
//            txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive=true
//            txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive=true
//        }else{
            txtFieldSearch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive=true
            txtFieldSearch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive=true
        //}

        txtFieldSearch.topAnchor.constraint(equalTo: myMapView.topAnchor, constant: 40).isActive=true
        txtFieldSearch.heightAnchor.constraint(equalToConstant: 35).isActive=true
        setupTextField(textField: txtFieldSearch, img: (UIImage(systemName: "magnifyingglass"))!)


        self.view.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: myMapView.bottomAnchor, constant: -20).isActive=true
        btnMyLocation.rightAnchor.constraint(equalTo: myMapView.rightAnchor, constant: -20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        

        self.view.addSubview(centerDot)
        centerDot.centerXAnchor.constraint(equalTo: myMapView.centerXAnchor).isActive=true
        centerDot.centerYAnchor.constraint(equalTo: myMapView.centerYAnchor).isActive=true
        centerDot.heightAnchor.constraint(equalToConstant: 5).isActive=true
        centerDot.widthAnchor.constraint(equalToConstant: 5).isActive=true
    }
    let myMapView: GMSMapView = {
        let v=GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let txtFieldSearch: UITextField = {
        let tf=UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .white
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.placeholder="Search for a location"
        //tf.font = UIFont(name: "GESSTwoMedium-Medium", size: 14)
        tf.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.layer.shadowRadius = 2
        tf.layer.shadowOpacity = 0.5
        tf.layer.shadowOffset = CGSize(width: 0, height: 0)
        tf.translatesAutoresizingMaskIntoConstraints=false
        return tf
    }()
    
    
    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "myLocation"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchDown)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let backBtn: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = .none
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.backgroundColor = .none
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(back), for: .touchDown)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let centerDot: UIButton = {
           let btn=UIButton()
           btn.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.cornerRadius=5
           btn.translatesAutoresizingMaskIntoConstraints=false
           return btn
       }()
    
    
    @objc func back() {
       self.navigationController?.popViewController(animated: true)
        //navigationController?.popToViewController(HomeViewController(), animated: true)
    }
    
    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            
            myMapView.animate(toLocation: (location?.coordinate)!)
            let camera = GMSCameraPosition.camera(withTarget: location!.coordinate, zoom: 18)
            self.myMapView.animate(to: camera)
            
        }
    }
    
    func setupTextField(textField: UITextField, img: UIImage){
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = img
        imageView.tintColor = .lightGray
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
    }
    
    private func AddMarker(title:String , snippet:String  , latitude:Double , longitude:Double){
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = snippet
        marker.map = myMapView
        bounds = bounds.includingCoordinate(marker.position)
       let update = GMSCameraUpdate.fit(bounds, withPadding: 0)
        myMapView.animate(with: update)
    }

}



extension GMSViewController: GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate,UITextFieldDelegate{
    //MARK: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        filter.type = .establishment
        filter.country = "JO"

        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        return false
    }
    

    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
      //  showPartyMarkers(lat: lat, long: long)
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        myMapView.camera = camera
        txtFieldSearch.text=place.formattedAddress
     //   chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
        let marker=GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "\(place.name)"
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = myMapView
        
        self.dismiss(animated: true, completion: nil) // dismiss after place selected
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        debugPrint("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initGoogleMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: sourceLat, longitude: sourceLong, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
        self.myMapView.animate(to: camera)
    }
    
    
 //Add marker when drag map
 func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
     geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
               guard error == nil else {return}
        debugPrint("response:",response)
        debugPrint("error:",error)
        
    self.myMapView.clear()
       if let result = response?.firstResult() {
         let marker = GMSMarker()
        marker.position = cameraPosition.target
         marker.title = result.lines?[0]
         marker.snippet = result.addressLine1()
         marker.map = mapView
        self.sourceLat=result.coordinate.latitude
        self.sourceLong=result.coordinate.longitude
        self.address=result.addressLine1() ?? result.lines?[0] as! String
        self.txtFieldSearch.placeholder = self.address

         debugPrint("marker.position \(marker.position), marker.title \( String(describing: marker.title)), marker.snippet\(result.addressLine1()), coordinate \(result.coordinate)")
        
       }
     }
   }
}
