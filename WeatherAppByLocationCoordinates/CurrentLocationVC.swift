//
//  CurrentLocationVC.swift
//  WeatherAppByLocationCoordinates
//
//  Created by Omar barkat on 04/11/2023.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import NVActivityIndicatorView
class CurrentLocationVC: UIViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var intecatorView: NVActivityIndicatorView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblTempp: UILabel!
    @IBOutlet weak var lblCurrentCity: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManger = CLLocationManager()
    var currentLocation : CLLocation?
    var latitude : CLLocationDegrees = 0.0
    var longitude : CLLocationDegrees = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intecatorView.color = .blue
        intecatorView.type = .lineScaleParty
        intecatorView.startAnimating()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.allowsBackgroundLocationUpdates = true
        if isLocationEnabled() {
            checkAuthorization()
        }else {
           alert(msg: "Please Enable Location Servise")
        }
    }
    
    @IBAction func btnSelectCity(_ sender: Any) {
        if let city = currentLocation {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityChanged"), object: nil, userInfo: ["city":city])
            dismiss(animated: true, completion: nil)
        }
    }
    func isLocationEnabled() ->Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    func checkAuthorization () {
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse :
            locationManger.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways :
            mapView.showsUserLocation = true
            break
        case .restricted :
            print("default ..")
            break
        case .denied :
            print("default ..")
            
            break
        default:
            print("default ..")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse :
            locationManger.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways :
            mapView.showsUserLocation = true
            break
       
        default:
            print("default ..")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  !locations.isEmpty , currentLocation == nil{
            currentLocation = locations.first
            locationManger.stopUpdatingLocation()
            requestWeatherForLocation()
            userlocation(location: currentLocation!)
        }
    }
    func requestWeatherForLocation() {
           guard let currentLocation = currentLocation else {
               return
           }
           var long = "\(currentLocation.coordinate.longitude)"
           var lat = "\(currentLocation.coordinate.latitude)"
        print(longitude)
        let params = ["lat":lat,"lon" :long , "appid":"e298833b6575646c6e5f94d15c4b98ff"]
    AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { [self] response in
        print(response.value)
        if let result = response.value{
        let json = result as! NSDictionary
                let weather = json["weather"] as! NSArray
                let description = weather[0] as! NSDictionary
            let description2 = description["description"] as! String
            let main = json["main"] as! NSDictionary
            let temp = main["temp"] as! Double
            let pressure = main["pressure"] as! Double
            let humidity = main["humidity"] as! Double
            let sys = json["sys"] as! NSDictionary
            let country = sys["country"] as! String
            print("\(country)")
            print("\(temp)")
            print("\(pressure)")
            print("\(humidity)")
            print(description2)
            intecatorView.isHidden = true

            lblTempp.text = "\(temp)"
            lblDescription.text = "\(description2)"
            lblPressure.text = "\(pressure)"
            lblHumidity.text = "\(humidity)"
            lblCurrentCity.text = ("\(country)")
        }
    }
    }
    func alert (msg:String) {
        let alert = UIAlertController(title: "alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func userlocation (location : CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}


