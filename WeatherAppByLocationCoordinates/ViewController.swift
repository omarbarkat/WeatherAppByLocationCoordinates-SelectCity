//
//  ViewController.swift
//  WeatherAppByLocationCoordinates
//
//  Created by Omar barkat on 04/11/2023.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSelectCity.layer.cornerRadius = 15
        btnCurrentLocation.layer.cornerRadius = 15

    }


}

