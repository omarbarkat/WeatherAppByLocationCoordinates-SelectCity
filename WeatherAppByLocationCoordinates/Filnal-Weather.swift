//
//  Filnal-Weather.swift
//  WeatherAppByLocationCoordinates
//
//  Created by Omar barkat on 04/11/2023.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class Filnal_Weather: UIViewController {
    var cityID = "360630"
    @IBOutlet weak var btnChangeCity: UIButton!
    @IBOutlet weak var indecatorView: NVActivityIndicatorView!
    @IBOutlet weak var lblSelectedCity: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblDecription: UILabel!
    override func viewDidLoad() {
        btnChangeCity.layer.cornerRadius = 15
        super.viewDidLoad()
        indecatorView.color = .blue
        indecatorView.type = .lineScaleParty
        indecatorView.startAnimating()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "cityChanged"), object: nil)
     //   NotificationCenter.default.addObserver(self, selector: #selector(changeCity), name: NSNotification.Name(rawValue: "CityNameChanged"), object: nil)
        getINFO()
    }
    func getINFO() {
        let params = ["id":cityID, "appid":"e298833b6575646c6e5f94d15c4b98ff"]
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { [self] response in
  //          print(response.value)
            if let result = response.value{
         //   print(result["main"])
            let json = result as! NSDictionary
                    let weather = json["weather"] as! NSArray
                    let description = weather[0] as! NSDictionary
                let description2 = description["description"] as! String
                let main = json["main"] as! NSDictionary
                let temp = main["temp"] as! Double
                let pressure = main["pressure"] as! Double
                let humidity = main["humidity"] as! Double
            print("\(temp)")
                print("\(pressure)")
                print("\(humidity)")
                print(description2)
              //  print("\(self.description)")
                indecatorView.isHidden = true
                self.lblTemp.text = "\(temp)"
                self.lblPressure.text = "\(pressure)"
                self.lblHumidity.text = "\(humidity)"
                self.lblDecription.text = "\(description2)"
        }
        }
    }
    @objc func cityChanged (notification : Notification) {
        if let city = notification.userInfo?["city"] as? City {
            lblSelectedCity.text = city.name
            cityID = city.id
            getINFO()      
        }
    }
  
}
