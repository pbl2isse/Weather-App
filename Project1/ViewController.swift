//
//  ViewController.swift
//  Project1
//
//  Created by Alaniah Nisrina on 11/15/17.
//  Copyright © 2017 ISSE. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var cities : [String] = ["Kyoto,JP", "Kusatsu,JP", "Jakarta,ID", "Bangkok,TH", "Manila,PH"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Weather App"
        print(cities)
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString: String
        let urlRope: String
        var jsonWeather: JSON?
        var jsonForecast: JSON?
        
        urlString =  "https://api.openweathermap.org/data/2.5/weather?q="+cities[indexPath.row]+"&appid=a5ff8344e2fbb334db408ba2738884f9"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                jsonWeather = try! JSON(data: data)
            }
        }
        
        urlRope =  "https://api.openweathermap.org/data/2.5/forecast?q="+cities[indexPath.row]+"&appid=a5ff8344e2fbb334db408ba2738884f9"
        if let url = URL(string: urlRope) {
            if let data = try? Data(contentsOf: url) {
                jsonForecast = try! JSON(data: data)
            }
        }
        
        
        
        print(jsonWeather!)
        print(jsonForecast!)
        let weatherData = ["temperature": "\(jsonWeather!["main"]["temp"].floatValue - 273.15)", "humidity": jsonWeather!["main"]["humidity"].stringValue, "weather": jsonWeather!["weather"][0]["main"].stringValue, "icon": jsonWeather!["weather"][0]["icon"].stringValue]
        let forecastData = ["icon": jsonForecast!["list"][0]["weather"][0]["icon"].stringValue]
                // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                    // 2: success! Set its selectedImage property
            vc.selectedImage = cities[indexPath.row]
                    
                    // 3: now push it onto the navigation controller
            vc.weather = weatherData
            vc.forecast = forecastData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



