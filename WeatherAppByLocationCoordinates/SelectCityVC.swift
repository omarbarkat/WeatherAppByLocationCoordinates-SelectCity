//
//  SelectCityVC.swift
//  WeatherAppByLocationCoordinates
//
//  Created by Omar barkat on 04/11/2023.
//

import UIKit

class SelectCityVC: UIViewController {
    var arrCities = [
        City(name: "cairo", id: "360630"),
        City(name: "alexandria", id: "361058"),
        City(name: "luxor", id: "360502"),
        City(name: "asiut", id: "361478"),

    ]

    var selectedCity: City?
    
    //  selectedCity = arrCities[row]


    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var pickerViewCities: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSelectCity.layer.cornerRadius = 15
        pickerViewCities.delegate = self
        pickerViewCities.dataSource = self
    }
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBAction func btnSelectedCity(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityChanged"), object: nil, userInfo: ["city":city])
            dismiss(animated: true, completion: nil)
        }
    }
}
extension SelectCityVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCities.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrCities[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = arrCities[row]

      //  print(SelectedCity)
    }
}
