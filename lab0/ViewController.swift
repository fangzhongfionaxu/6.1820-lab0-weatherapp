//
//  ViewController.swift
//  lab0
//
//  Created by FionaXu on 2/8/26.
//

import UIKit

class ViewController: UIViewController {
    
    var weather = Weather()
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var visibility: UILabel!
    
    @IBOutlet weak var zipcode: UITextField!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    

    
    @IBAction func getWeather(_ sender: UIButton) {
        NSLog("Get weather!!")
        sender.isEnabled = false
            weather.fetchWeatherForZip(zip: zipcode.text!, completionHandler: {(ret: Bool)->Void in
                if (ret)
                {
                    NSLog("Succeeded")

                    self.temperature.text = self.weather.currentTemp
                    self.desc.text = self.weather.weatherDescription
                    self.humidity.text = self.weather.relativeHumidity
                    self.wind.text = self.weather.windString
                    self.visibility.text = self.weather.visibilityKm
                } else {
                    NSLog("Failed")
                }
                sender.isEnabled = true
            })

        zipcode.resignFirstResponder()
    }

    
    
    
    
    @IBAction func Touch(_ sender: UITapGestureRecognizer) {
        zipcode.resignFirstResponder()
    }
    
}

