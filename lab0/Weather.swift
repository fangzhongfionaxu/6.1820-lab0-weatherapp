//
//  Weather.swift
//  lab0
//
//  Created by FionaXu on 2/8/26.
//

import UIKit

class Weather: NSObject {
    var currentTemp: String = ""
    var weatherDescription: String = ""
    var relativeHumidity: String = ""
    var windString : String = ""
    var visibilityKm : String = ""
    
    var APP_ID = "a6009178b879128a57a47844d88215c7"
    
    
    func fetchWeatherForZip(zip:String, completionHandler: @escaping (Bool) -> Void) -> Void {
        NSLog("Getting for:  \(zip)")
        let urlString : String = "https://api.openweathermap.org/data/2.5/weather?zip=\(zip)&appid=\(APP_ID)&units=imperial"

        NSLog(urlString)

        let weatherURL = URL(string: urlString)

        let session = URLSession.shared
        let request = URLRequest(url: weatherURL!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 5.0)

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                let ret = self.parseData(data: data)
            DispatchQueue.main.async(execute: {()->Void in completionHandler(ret)})
        })

        task.resume()

    }
    
    func parseData(data : Data?) -> Bool{
        if(data == nil)
        {
            return false
        }
        let jsonObject = try? JSONSerialization.jsonObject(with: data!, options:[])
        
        if(jsonObject != nil)
        {
            let jsonObjectTmp : [String :AnyObject] = jsonObject as! [String:AnyObject]
            let currentObservations:[String:AnyObject] = jsonObjectTmp["main"] as! [String:AnyObject]
            let weatherArray:[[String:AnyObject]] = jsonObjectTmp["weather"] as! [[String:AnyObject]]
            let windObservations:[String:AnyObject] = jsonObjectTmp["wind"] as! [String:AnyObject]
            let visibility:Double = jsonObjectTmp["visibility"] as! Double
            
            
            self.currentTemp = "\(currentObservations["temp"] as! Double)"
            self.weatherDescription = (weatherArray[0]["description"] as! String?)!
            self.relativeHumidity = "humidity: \(currentObservations["humidity"] as! Double)"
            self.windString = "Wind speed at \(windObservations["speed"] as! Double) meter/sec, gust at \(windObservations["speed"] as! Double) meter/sec"
            self.visibilityKm = "\(visibility) km"
            
            NSLog(self.relativeHumidity)

        }
        return true
    }
    

}
